`timescale 1ns / 1ps

// Compact CAN 2.0A controller/monitor for a fixed 500 kbit/s bus.  It receives
// 11-bit data frames through a second transceiver, can ACK valid peer frames,
// auto-echo them, and can transmit a deterministic 0x321 diagnostic frame.
// TX intent is compared with RXD so arbitration loss / bit mismatch remains
// observable while the FPGA participates as an active second CAN node.
module can_passive_monitor #(
    parameter integer CLK_HZ = 100000000,
    parameter integer BITRATE = 500000,
    parameter integer SAMPLE_PERCENT = 75,
    parameter integer CHECK_TX_INTENT = 1,
    parameter [3:0] CHANNEL = 4'd0
) (
    input  wire         clk,
    input  wire         rst_n,
    input  wire [63:0]  timestamp,
    input  wire         can_tx_intent,
    input  wire         can_rx_bus,
    input  wire         ack_enable,
    input  wire         echo_enable,
    input  wire         tx_request,
    output wire         can_tx,
    output wire         can_rx_level,
    output reg          evt_valid,
    input  wire         evt_ready,
    output reg          evt_trigger,
    output reg  [127:0] evt_data,
    output reg  [31:0]  dropped_event_count
);

localparam integer CLKS_PER_BIT = CLK_HZ / BITRATE;
localparam integer SAMPLE_CLKS = (CLKS_PER_BIT * SAMPLE_PERCENT) / 100;
localparam [3:0] PROTOCOL_CAN = 4'h4;
localparam [1:0] DIRECTION_DUPLEX = 2'b11;
localparam [5:0] EVENT_START = 6'h00;
localparam [5:0] EVENT_DATA  = 6'h01;
localparam [5:0] EVENT_END   = 6'h02;
localparam [5:0] EVENT_ERROR = 6'h3F;
localparam [7:0] ERR_ACK   = 8'h01;
localparam [7:0] ERR_BIT   = 8'h02;
localparam [7:0] ERR_STUFF = 8'h03;
localparam [7:0] ERR_CRC   = 8'h04;
localparam [7:0] ERR_FORM  = 8'h05;

localparam [2:0] PH_IDLE      = 3'd0;
localparam [2:0] PH_STUFFED   = 3'd1;
localparam [2:0] PH_CRC_DELIM = 3'd2;
localparam [2:0] PH_ACK       = 3'd3;
localparam [2:0] PH_ACK_DELIM = 3'd4;
localparam [2:0] PH_EOF       = 3'd5;

(* ASYNC_REG = "TRUE" *) reg rx_meta, rx_sync;
(* ASYNC_REG = "TRUE" *) reg tx_meta, tx_sync;
reg rx_d;
reg [2:0] phase;
reg [15:0] bit_timer;
reg [7:0] logical_index;
reg last_raw_bit;
reg [2:0] same_count;
reg expect_stuff;
reg local_tx_active;
reg bit_error_reported;
reg stuff_error_reported;
reg form_error_reported;
reg [23:0] transaction_id;
reg [10:0] identifier;
reg rtr;
reg ide;
reg [3:0] dlc_shift;
reg [3:0] dlc;
reg [7:0] data_end_index;
reg [2:0] data_bit_count;
reg [7:0] data_shift;
reg [7:0] data_byte_index;
reg [14:0] crc_calc;
reg [14:0] crc_received;
reg [3:0] eof_count;
reg crc_complete_pending;
reg frame_valid;
reg ack_drive;
reg tx_drive;
reg [63:0] payload;
reg [10:0] tx_identifier;
reg [3:0] tx_dlc;
reg [63:0] tx_payload;
reg [7:0] tx_logical_index;
reg [7:0] tx_data_end;
reg [14:0] tx_crc;
reg tx_last_raw;
reg [2:0] tx_same_count;
reg tx_current_stuff;
reg [2:0] tx_phase;
reg [3:0] tx_eof_count;
reg [9:0] tx_timer;
reg [9:0] tx_wait_timer;
reg tx_pending;
reg tx_active;
reg tx_request_d;

localparam [2:0] TX_STUFFED   = 3'd0;
localparam [2:0] TX_CRC_DELIM = 3'd1;
localparam [2:0] TX_ACK       = 3'd2;
localparam [2:0] TX_ACK_DELIM = 3'd3;
localparam [2:0] TX_EOF       = 3'd4;

assign can_tx = ack_drive & tx_drive;
assign can_rx_level = rx_sync;

wire sof_edge = rx_d && !rx_sync;

function automatic [14:0] crc15_next;
    input [14:0] value;
    input bit_value;
    reg feedback;
    reg [14:0] shifted;
    begin
        feedback = value[14] ^ bit_value;
        shifted = {value[13:0], 1'b0};
        crc15_next = feedback ? (shifted ^ 15'h4599) : shifted;
    end
endfunction

function automatic [127:0] make_event;
    input [63:0] event_timestamp;
    input [5:0] event_type;
    input [15:0] flags;
    input [7:0] payload_length;
    input [23:0] event_transaction_id;
    begin
        make_event = {event_timestamp, PROTOCOL_CAN, CHANNEL,
                      DIRECTION_DUPLEX, event_type, flags,
                      payload_length, event_transaction_id};
    end
endfunction

task automatic offer_event;
    input [127:0] value;
    input trigger;
    begin
        if (!evt_valid || evt_ready) begin
            evt_valid <= 1'b1;
            evt_trigger <= trigger;
            evt_data <= value;
        end else begin
            dropped_event_count <= dropped_event_count + 32'd1;
        end
    end
endtask

function automatic tx_logical_bit;
    input [7:0] index;
    input [10:0] frame_id;
    input [3:0] frame_dlc;
    input [63:0] frame_payload;
    begin
        if (index == 0) tx_logical_bit = 1'b0;
        else if (index <= 11) tx_logical_bit = frame_id[11-index];
        else if (index <= 14) tx_logical_bit = 1'b0;
        else if (index <= 18) tx_logical_bit = frame_dlc[18-index];
        else tx_logical_bit = frame_payload[63-(index-19)];
    end
endfunction

task automatic prepare_echo;
    input [10:0] frame_id;
    input [3:0] frame_dlc;
    input [63:0] frame_payload;
    begin
        tx_identifier <= frame_id;
        tx_dlc <= frame_dlc > 8 ? 4'd8 : frame_dlc;
        tx_payload <= frame_payload;
        tx_pending <= 1'b1;
        tx_wait_timer <= 10'd0;
    end
endtask

task automatic advance_tx_logical;
    input [14:0] crc_value;
    reg [7:0] next_index;
    reg next_bit;
    begin
        next_index = tx_logical_index + 8'd1;
        if (next_index < tx_data_end) begin
            next_bit = tx_logical_bit(next_index, tx_identifier,
                                      tx_dlc, tx_payload);
        end else if (next_index <= tx_data_end + 8'd14) begin
            next_bit = crc_value[14-(next_index-tx_data_end)];
        end else begin
            next_bit = 1'b1;
            tx_phase <= TX_CRC_DELIM;
        end
        tx_logical_index <= next_index;
        tx_drive <= next_bit;
        tx_current_stuff <= 1'b0;
        if (next_bit == tx_last_raw)
            tx_same_count <= tx_same_count + 3'd1;
        else begin
            tx_last_raw <= next_bit;
            tx_same_count <= 3'd1;
        end
    end
endtask

task automatic report_form_error;
    input [7:0] detail;
    begin
        if (!form_error_reported) begin
            offer_event(make_event(timestamp, EVENT_ERROR,
                {ERR_FORM, detail}, 8'd0, transaction_id), 1'b1);
            form_error_reported <= 1'b1;
        end
        frame_valid <= 1'b0;
    end
endtask

always @(posedge clk) begin : monitor_process
    reg sampled;
    reg [3:0] next_dlc;
    reg [14:0] next_crc_rx;
    reg [14:0] tx_next_crc;
    if (!rst_n) begin
        rx_meta <= 1'b1; rx_sync <= 1'b1; rx_d <= 1'b1;
        tx_meta <= 1'b1; tx_sync <= 1'b1;
        phase <= PH_IDLE;
        bit_timer <= 16'd0;
        logical_index <= 8'd0;
        last_raw_bit <= 1'b1;
        same_count <= 3'd0;
        expect_stuff <= 1'b0;
        local_tx_active <= 1'b0;
        bit_error_reported <= 1'b0;
        stuff_error_reported <= 1'b0;
        form_error_reported <= 1'b0;
        transaction_id <= 24'd0;
        identifier <= 11'd0;
        rtr <= 1'b0; ide <= 1'b0;
        dlc_shift <= 4'd0; dlc <= 4'd0;
        data_end_index <= 8'd19;
        data_bit_count <= 3'd0;
        data_shift <= 8'd0;
        data_byte_index <= 8'd0;
        crc_calc <= 15'd0;
        crc_received <= 15'd0;
        eof_count <= 4'd0;
        crc_complete_pending <= 1'b0;
        frame_valid <= 1'b0;
        ack_drive <= 1'b1;
        tx_drive <= 1'b1;
        payload <= 64'd0;
        tx_identifier <= 11'd0;
        tx_dlc <= 4'd0;
        tx_payload <= 64'd0;
        tx_logical_index <= 8'd0;
        tx_data_end <= 8'd19;
        tx_crc <= 15'd0;
        tx_last_raw <= 1'b1;
        tx_same_count <= 3'd0;
        tx_current_stuff <= 1'b0;
        tx_phase <= TX_STUFFED;
        tx_eof_count <= 4'd0;
        tx_timer <= 10'd0;
        tx_wait_timer <= 10'd0;
        tx_pending <= 1'b0;
        tx_active <= 1'b0;
        tx_request_d <= 1'b0;
        evt_valid <= 1'b0;
        evt_trigger <= 1'b0;
        evt_data <= 128'd0;
        dropped_event_count <= 32'd0;
    end else begin
        rx_meta <= can_rx_bus; rx_sync <= rx_meta; rx_d <= rx_sync;
        tx_meta <= can_tx_intent; tx_sync <= tx_meta;
        tx_request_d <= tx_request;
        if (tx_request && !tx_request_d && phase == PH_IDLE &&
            !tx_pending && !tx_active)
            prepare_echo(11'h321, 4'd8, 64'h0001020304050607);
        if (evt_valid && evt_ready) begin
            evt_valid <= 1'b0;
            evt_trigger <= 1'b0;
        end

        if (phase == PH_IDLE) begin
            bit_timer <= 16'd0;
            if (sof_edge) begin
                phase <= PH_STUFFED;
                transaction_id <= transaction_id + 24'd1;
                logical_index <= 8'd0;
                last_raw_bit <= 1'b1;
                same_count <= 3'd0;
                expect_stuff <= 1'b0;
                local_tx_active <= (CHECK_TX_INTENT != 0) && !tx_sync;
                bit_error_reported <= 1'b0;
                stuff_error_reported <= 1'b0;
                form_error_reported <= 1'b0;
                identifier <= 11'd0;
                rtr <= 1'b0; ide <= 1'b0;
                dlc_shift <= 4'd0; dlc <= 4'd0;
                data_end_index <= 8'd19;
                data_bit_count <= 3'd0;
                data_shift <= 8'd0;
                data_byte_index <= 8'd0;
                crc_calc <= 15'd0;
                crc_received <= 15'd0;
                eof_count <= 4'd0;
                crc_complete_pending <= 1'b0;
                frame_valid <= 1'b1;
                ack_drive <= 1'b1;
                payload <= 64'd0;
                offer_event(make_event(timestamp, EVENT_START, 16'd0,
                    8'd0, transaction_id + 24'd1), 1'b0);
            end
        end else begin
            if (bit_timer == CLKS_PER_BIT - 1)
                bit_timer <= 16'd0;
            else
                bit_timer <= bit_timer + 16'd1;

            if (bit_timer == SAMPLE_CLKS - 1) begin
                sampled = rx_sync;

                if (local_tx_active && phase != PH_ACK && tx_sync != sampled) begin
                    if (phase == PH_STUFFED && logical_index <= 8'd12 &&
                        tx_sync && !sampled) begin
                        // Recessive lost to dominant during arbitration.
                        local_tx_active <= 1'b0;
                    end else if (!bit_error_reported) begin
                        offer_event(make_event(timestamp, EVENT_ERROR,
                            {ERR_BIT, logical_index}, 8'd0,
                            transaction_id), 1'b1);
                        bit_error_reported <= 1'b1;
                    end
                end

                case (phase)
                    PH_STUFFED: begin
                        if (expect_stuff) begin
                            if (sampled == last_raw_bit && !stuff_error_reported) begin
                                offer_event(make_event(timestamp, EVENT_ERROR,
                                    {ERR_STUFF, logical_index}, 8'd0,
                                    transaction_id), 1'b1);
                                stuff_error_reported <= 1'b1;
                                frame_valid <= 1'b0;
                            end
                            last_raw_bit <= sampled;
                            same_count <= 3'd1;
                            expect_stuff <= 1'b0;
                            if (crc_complete_pending) begin
                                phase <= PH_CRC_DELIM;
                                crc_complete_pending <= 1'b0;
                            end
                        end else begin
                            if (same_count == 0 || sampled != last_raw_bit) begin
                                last_raw_bit <= sampled;
                                same_count <= 3'd1;
                            end else if (same_count == 3'd4) begin
                                same_count <= 3'd5;
                                expect_stuff <= 1'b1;
                            end else begin
                                same_count <= same_count + 3'd1;
                            end

                            if (logical_index == 0 && sampled != 1'b0)
                                report_form_error(8'h00);
                            if (logical_index >= 1 && logical_index <= 11)
                                identifier <= {identifier[9:0], sampled};
                            else if (logical_index == 12) rtr <= sampled;
                            else if (logical_index == 13) begin
                                ide <= sampled;
                                if (sampled) report_form_error(8'h13);
                            end else if (logical_index == 14 && sampled)
                                report_form_error(8'h14);
                            else if (logical_index >= 15 && logical_index <= 18) begin
                                dlc_shift <= {dlc_shift[2:0], sampled};
                                if (logical_index == 18) begin
                                    next_dlc = {dlc_shift[2:0], sampled};
                                    dlc <= next_dlc > 8 ? 4'd8 : next_dlc;
                                    data_end_index <= 8'd19 +
                                        ((next_dlc > 8 ? 8 : next_dlc) << 3);
                                end
                            end else if (logical_index >= 19 &&
                                         logical_index < data_end_index) begin
                                data_shift <= {data_shift[6:0], sampled};
                                if (data_bit_count == 3'd7) begin
                                    offer_event(make_event(timestamp, EVENT_DATA,
                                        {data_byte_index,
                                         data_shift[6:0], sampled},
                                        8'd1, transaction_id), 1'b0);
                                    data_byte_index <= data_byte_index + 8'd1;
                                    payload[63-(data_byte_index*8) -: 8] <=
                                        {data_shift[6:0], sampled};
                                    data_bit_count <= 3'd0;
                                end else begin
                                    data_bit_count <= data_bit_count + 3'd1;
                                end
                            end

                            if (logical_index < data_end_index)
                                crc_calc <= crc15_next(crc_calc, sampled);
                            else begin
                                next_crc_rx = {crc_received[13:0], sampled};
                                crc_received <= next_crc_rx;
                                if (logical_index == data_end_index + 8'd14) begin
                                    // A stuffing violation corrupts the decoded
                                    // bit stream, so a later CRC mismatch is a
                                    // consequence of the same primary fault.
                                    // Keep parsing to recover the frame boundary,
                                    // but do not emit a second primary error.
                                    if (next_crc_rx != crc_calc &&
                                        !stuff_error_reported)
                                        offer_event(make_event(timestamp,
                                            EVENT_ERROR,
                                            {ERR_CRC, 8'd0}, 8'd0,
                                            transaction_id), 1'b1);
                                    if (next_crc_rx != crc_calc)
                                        frame_valid <= 1'b0;
                                    if (same_count == 3'd4 &&
                                        sampled == last_raw_bit)
                                        crc_complete_pending <= 1'b1;
                                    else begin
                                        phase <= PH_CRC_DELIM;
                                        expect_stuff <= 1'b0;
                                    end
                                end
                            end
                            logical_index <= logical_index + 8'd1;
                        end
                    end
                    PH_CRC_DELIM: begin
                        if (!sampled) report_form_error(8'hC1);
                        if (sampled && frame_valid && ack_enable && !local_tx_active)
                            ack_drive <= 1'b0;
                        phase <= PH_ACK;
                    end
                    PH_ACK: begin
                        if (sampled)
                            offer_event(make_event(timestamp, EVENT_ERROR,
                                {ERR_ACK, 8'd0}, 8'd0,
                                transaction_id), 1'b1);
                        ack_drive <= 1'b1;
                        phase <= PH_ACK_DELIM;
                    end
                    PH_ACK_DELIM: begin
                        if (!sampled) report_form_error(8'hA1);
                        phase <= PH_EOF;
                        eof_count <= 4'd0;
                    end
                    PH_EOF: begin
                        if (!sampled) report_form_error({4'hE, eof_count});
                        if (eof_count == 4'd6) begin
                            offer_event(make_event(timestamp, EVENT_END,
                                {dlc, 1'b0, identifier}, dlc,
                                transaction_id), 1'b0);
                            if (frame_valid && !local_tx_active && echo_enable &&
                                !tx_pending && !tx_active)
                                prepare_echo(identifier, dlc, payload);
                            phase <= PH_IDLE;
                        end else begin
                            eof_count <= eof_count + 4'd1;
                        end
                    end
                    default: begin phase <= PH_IDLE; ack_drive <= 1'b1; end
                endcase
            end
        end

        if (tx_active) begin
            if (tx_timer == CLKS_PER_BIT - 1) begin
                tx_timer <= 10'd0;
                case (tx_phase)
                    TX_STUFFED: begin
                        if (tx_current_stuff) begin
                            advance_tx_logical(tx_crc);
                        end else begin
                            tx_next_crc = tx_crc;
                            if (tx_logical_index < tx_data_end)
                                tx_next_crc = crc15_next(tx_crc, tx_drive);
                            tx_crc <= tx_next_crc;
                            if (tx_same_count == 3'd5) begin
                                tx_drive <= !tx_last_raw;
                                tx_last_raw <= !tx_last_raw;
                                tx_same_count <= 3'd1;
                                tx_current_stuff <= 1'b1;
                            end else begin
                                advance_tx_logical(tx_next_crc);
                            end
                        end
                    end
                    TX_CRC_DELIM: begin
                        tx_phase <= TX_ACK;
                        tx_drive <= 1'b1;
                    end
                    TX_ACK: begin
                        tx_phase <= TX_ACK_DELIM;
                        tx_drive <= 1'b1;
                    end
                    TX_ACK_DELIM: begin
                        tx_phase <= TX_EOF;
                        tx_eof_count <= 4'd0;
                        tx_drive <= 1'b1;
                    end
                    TX_EOF: begin
                        if (tx_eof_count == 4'd6) begin
                            tx_active <= 1'b0;
                            tx_drive <= 1'b1;
                        end else begin
                            tx_eof_count <= tx_eof_count + 4'd1;
                        end
                    end
                    default: begin
                        tx_active <= 1'b0;
                        tx_drive <= 1'b1;
                    end
                endcase
            end else begin
                tx_timer <= tx_timer + 10'd1;
            end
        end else if (tx_pending) begin
            if (tx_wait_timer == (CLKS_PER_BIT * 3) - 1) begin
                tx_pending <= 1'b0;
                tx_active <= 1'b1;
                tx_timer <= 10'd0;
                tx_phase <= TX_STUFFED;
                tx_logical_index <= 8'd0;
                tx_data_end <= 8'd19 + (tx_dlc << 3);
                tx_crc <= 15'd0;
                tx_last_raw <= 1'b0;
                tx_same_count <= 3'd1;
                tx_current_stuff <= 1'b0;
                tx_drive <= 1'b0;
            end else begin
                tx_wait_timer <= tx_wait_timer + 10'd1;
            end
        end
    end
end

endmodule
