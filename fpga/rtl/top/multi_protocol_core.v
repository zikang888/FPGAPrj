`timescale 1ns / 1ps

module multi_protocol_core (
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s_axi_aclk CLK" *)
    (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_aclk, ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_aresetn, FREQ_HZ 100000000" *)
    input  wire         s_axi_aclk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s_axi_aresetn RST" *)
    (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_aresetn, POLARITY ACTIVE_LOW" *)
    input  wire         s_axi_aresetn,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *)
    (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, PROTOCOL AXI4LITE, DATA_WIDTH 32, ADDR_WIDTH 16, FREQ_HZ 100000000, ID_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, SUPPORTS_NARROW_BURST 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1" *)
    input  wire [15:0]  s_axi_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *)
    input  wire         s_axi_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *)
    output reg          s_axi_awready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *)
    input  wire [31:0]  s_axi_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *)
    input  wire [3:0]   s_axi_wstrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *)
    input  wire         s_axi_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *)
    output reg          s_axi_wready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *)
    output reg  [1:0]   s_axi_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *)
    output reg          s_axi_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *)
    input  wire         s_axi_bready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *)
    input  wire [15:0]  s_axi_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *)
    input  wire         s_axi_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *)
    output reg          s_axi_arready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *)
    output reg  [31:0]  s_axi_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *)
    output reg  [1:0]   s_axi_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *)
    output reg          s_axi_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *)
    input  wire         s_axi_rready,
    input  wire         ext_evt_valid,
    output wire         ext_evt_ready,
    input  wire [127:0] ext_evt_data,
    input  wire         ext_evt_trigger,
    input  wire [31:0]  ext_evt_dropped_count,
    output wire         led_heartbeat,
    output wire         led_ps_active
);

localparam [31:0] SYS_ID_VALUE       = 32'h4D50_5254; // "MPRT"
localparam [31:0] VERSION_VALUE      = 32'h0001_0002; // event format v1, platform 2
localparam [31:0] BUILD_ID_VALUE     = 32'h2026_0923;
localparam [31:0] CAPABILITIES_VALUE = 32'h0000_0003; // bit0: snapshot, bit1: external event ingress

localparam [15:0] REG_SYS_ID       = 16'h0000;
localparam [15:0] REG_VERSION      = 16'h0004;
localparam [15:0] REG_BUILD_ID     = 16'h0008;
localparam [15:0] REG_CAPABILITIES = 16'h000C;
localparam [15:0] REG_SYS_CTRL     = 16'h0010;
localparam [15:0] REG_SYS_STATUS   = 16'h0014;
localparam [15:0] REG_IO_MODE      = 16'h0018;
localparam [15:0] REG_IRQ_STATUS   = 16'h001C;
localparam [15:0] REG_IRQ_ENABLE   = 16'h0020;
localparam [15:0] REG_TIMESTAMP_LO = 16'h0024;
localparam [15:0] REG_TIMESTAMP_HI = 16'h0028;
localparam [15:0] REG_SCRATCH      = 16'h002C;
localparam [15:0] REG_LED_CTRL     = 16'h0030;
localparam [15:0] REG_EVENT_ARB_STATUS = 16'h0034;
localparam [15:0] REG_EXT_DROPPED_COUNT = 16'h0038;

localparam [15:0] REG_CAPTURE_CTRL    = 16'h1000;
localparam [15:0] REG_CAPTURE_STATUS  = 16'h1004;
localparam [15:0] REG_SNAPSHOT_ID     = 16'h1008;
localparam [15:0] REG_SNAPSHOT_COUNT  = 16'h100C;
localparam [15:0] REG_TRIGGER_INDEX   = 16'h1010;
localparam [15:0] REG_DROPPED_COUNT   = 16'h1014;
localparam [15:0] REG_VIRTUAL_EVENT   = 16'h1018;
localparam [15:0] SNAPSHOT_BASE       = 16'h6000;

reg [31:0] sys_ctrl_reg;
reg [31:0] io_mode_reg;
reg [31:0] irq_status_reg;
reg [31:0] irq_enable_reg;
reg [31:0] scratch_reg;
reg [31:0] led_ctrl_reg;
reg [31:0] dropped_count_reg;

reg         capture_arm_pulse;
reg         capture_ack_pulse;
reg         virtual_evt_valid;
wire        virtual_evt_ready;
reg         virtual_evt_trigger;
reg [127:0] virtual_evt_data;
wire        capture_event_valid;
wire        capture_event_trigger;
wire [127:0] capture_event_data;
wire        capture_event_source;
wire [31:0] event_contention_count;
wire        capture_active;
wire        snapshot_ready;
wire [31:0] snapshot_id;
wire [8:0]  snapshot_count;
wire [7:0]  snapshot_trigger_index;
wire        snapshot_overwritten;

reg         snapshot_rd_en;
reg  [7:0]  snapshot_rd_index;
wire        snapshot_rd_valid;
wire [127:0] snapshot_rd_event;
reg         snapshot_read_pending;
reg  [1:0]  snapshot_word_select;

reg [63:0] timestamp_counter;
reg [63:0] timestamp_shadow;
reg [25:0] heartbeat_counter;
reg        heartbeat_state;

reg [15:0] awaddr_reg;
reg [31:0] wdata_reg;
reg [3:0]  wstrb_reg;
reg        aw_pending;
reg        w_pending;

wire aw_hs;
wire w_hs;
wire write_commit;
wire [15:0] write_addr;
wire [31:0] write_data;
wire [3:0]  write_strb;
wire ar_hs;
wire snapshot_read_address;
wire arm_command;
wire soft_trigger_command;
wire virtual_event_command;
wire virtual_enqueue_command;
wire virtual_enqueue_ready;
wire virtual_overflow;
wire capture_input_ready;
wire capture_event_accept;
wire inactive_event_drop;

assign aw_hs = s_axi_awvalid && s_axi_awready;
assign w_hs = s_axi_wvalid && s_axi_wready;
assign write_commit = !s_axi_bvalid &&
                      (aw_pending || aw_hs) &&
                      (w_pending || w_hs);
assign write_addr = aw_pending ? awaddr_reg : s_axi_awaddr;
assign write_data = w_pending ? wdata_reg : s_axi_wdata;
assign write_strb = w_pending ? wstrb_reg : s_axi_wstrb;
assign ar_hs = s_axi_arvalid && s_axi_arready;
assign snapshot_read_address = (s_axi_araddr[15:12] == 4'h6);
assign arm_command = write_commit && write_addr == REG_CAPTURE_CTRL &&
                     write_strb[0] && write_data[0];
assign soft_trigger_command = write_commit && write_addr == REG_CAPTURE_CTRL &&
                              write_strb[0] && write_data[2];
assign virtual_event_command = write_commit && write_addr == REG_VIRTUAL_EVENT;
assign virtual_enqueue_command = soft_trigger_command || virtual_event_command;
assign virtual_enqueue_ready = !virtual_evt_valid || virtual_evt_ready;
assign virtual_overflow = virtual_enqueue_command && !virtual_enqueue_ready;
assign capture_input_ready = !arm_command && !capture_arm_pulse;
assign capture_event_accept = capture_event_valid && capture_input_ready;
assign inactive_event_drop = capture_event_accept && !capture_active;

assign led_heartbeat = heartbeat_state;
assign led_ps_active = led_ctrl_reg[0];

function [31:0] apply_wstrb;
    input [31:0] previous;
    input [31:0] value;
    input [3:0]  strobe;
    begin
        apply_wstrb = previous;
        if (strobe[0]) apply_wstrb[7:0]   = value[7:0];
        if (strobe[1]) apply_wstrb[15:8]  = value[15:8];
        if (strobe[2]) apply_wstrb[23:16] = value[23:16];
        if (strobe[3]) apply_wstrb[31:24] = value[31:24];
    end
endfunction

function [31:0] read_register;
    input [15:0] addr;
    begin
        case (addr)
            REG_SYS_ID:       read_register = SYS_ID_VALUE;
            REG_VERSION:      read_register = VERSION_VALUE;
            REG_BUILD_ID:     read_register = BUILD_ID_VALUE;
            REG_CAPABILITIES: read_register = CAPABILITIES_VALUE;
            REG_SYS_CTRL:     read_register = sys_ctrl_reg;
            REG_SYS_STATUS:   read_register = 32'h0000_0001;
            REG_IO_MODE:      read_register = io_mode_reg;
            REG_IRQ_STATUS:   read_register = irq_status_reg;
            REG_IRQ_ENABLE:   read_register = irq_enable_reg;
            REG_TIMESTAMP_LO: read_register = timestamp_counter[31:0];
            REG_TIMESTAMP_HI: read_register = timestamp_shadow[63:32];
            REG_SCRATCH:      read_register = scratch_reg;
            REG_LED_CTRL:     read_register = led_ctrl_reg;
            REG_EVENT_ARB_STATUS: read_register = event_contention_count;
            REG_EXT_DROPPED_COUNT: read_register = ext_evt_dropped_count;
            REG_CAPTURE_STATUS: read_register = {
                28'd0,
                ((dropped_count_reg != 0) || (ext_evt_dropped_count != 0)),
                snapshot_overwritten,
                snapshot_ready,
                capture_active
            };
            REG_SNAPSHOT_ID:    read_register = snapshot_id;
            REG_SNAPSHOT_COUNT: read_register = {23'd0, snapshot_count};
            REG_TRIGGER_INDEX:  read_register = {24'd0, snapshot_trigger_index};
            REG_DROPPED_COUNT:  read_register = dropped_count_reg;
            default:          read_register = 32'h0000_0000;
        endcase
    end
endfunction

event_arbiter_2 #(
    .EVENT_WIDTH(128)
) event_arbiter (
    .clk(s_axi_aclk),
    .rst_n(s_axi_aresetn),
    .s0_valid(virtual_evt_valid),
    .s0_ready(virtual_evt_ready),
    .s0_data(virtual_evt_data),
    .s0_trigger(virtual_evt_trigger),
    .s1_valid(ext_evt_valid),
    .s1_ready(ext_evt_ready),
    .s1_data(ext_evt_data),
    .s1_trigger(ext_evt_trigger),
    .out_valid(capture_event_valid),
    .out_ready(capture_input_ready),
    .out_data(capture_event_data),
    .out_trigger(capture_event_trigger),
    .out_source(capture_event_source),
    .contention_count(event_contention_count)
);

event_snapshot_buffer #(
    .EVENT_WIDTH(128),
    .DEPTH(256),
    .POST_TRIGGER_EVENTS(16)
) capture_buffer (
    .clk(s_axi_aclk),
    .rst_n(s_axi_aresetn),
    .arm(capture_arm_pulse),
    .ack(capture_ack_pulse),
    .in_valid(capture_event_valid),
    .in_event(capture_event_data),
    .in_trigger(capture_event_trigger),
    .capture_active(capture_active),
    .snapshot_ready(snapshot_ready),
    .snapshot_id(snapshot_id),
    .snapshot_count(snapshot_count),
    .snapshot_trigger_index(snapshot_trigger_index),
    .overwritten(snapshot_overwritten),
    .rd_en(snapshot_rd_en),
    .rd_index(snapshot_rd_index),
    .rd_valid(snapshot_rd_valid),
    .rd_event(snapshot_rd_event)
);

always @(posedge s_axi_aclk) begin
    if (!s_axi_aresetn) begin
        s_axi_awready    <= 1'b0;
        s_axi_wready     <= 1'b0;
        s_axi_bresp      <= 2'b00;
        s_axi_bvalid     <= 1'b0;
        s_axi_arready    <= 1'b0;
        s_axi_rdata      <= 32'd0;
        s_axi_rresp      <= 2'b00;
        s_axi_rvalid     <= 1'b0;
        awaddr_reg       <= 16'd0;
        wdata_reg        <= 32'd0;
        wstrb_reg        <= 4'd0;
        aw_pending       <= 1'b0;
        w_pending        <= 1'b0;
        sys_ctrl_reg     <= 32'd0;
        io_mode_reg      <= 32'd0;
        irq_status_reg   <= 32'd0;
        irq_enable_reg   <= 32'd0;
        scratch_reg      <= 32'd0;
        led_ctrl_reg     <= 32'd0;
        dropped_count_reg <= 32'd0;
        capture_arm_pulse <= 1'b0;
        capture_ack_pulse <= 1'b0;
        virtual_evt_valid <= 1'b0;
        virtual_evt_trigger <= 1'b0;
        virtual_evt_data <= 128'd0;
        snapshot_rd_en <= 1'b0;
        snapshot_rd_index <= 8'd0;
        snapshot_read_pending <= 1'b0;
        snapshot_word_select <= 2'd0;
        timestamp_counter <= 64'd0;
        timestamp_shadow <= 64'd0;
        heartbeat_counter <= 26'd0;
        heartbeat_state  <= 1'b0;
    end else begin
        timestamp_counter <= timestamp_counter + 64'd1;
        capture_arm_pulse <= 1'b0;
        capture_ack_pulse <= 1'b0;
        snapshot_rd_en <= 1'b0;

        if (virtual_evt_valid && virtual_evt_ready) begin
            virtual_evt_valid <= 1'b0;
            virtual_evt_trigger <= 1'b0;
        end

        if (arm_command) begin
            dropped_count_reg <= 32'd0;
        end else begin
            case ({inactive_event_drop, virtual_overflow})
                2'b01, 2'b10: dropped_count_reg <= dropped_count_reg + 32'd1;
                2'b11:        dropped_count_reg <= dropped_count_reg + 32'd2;
                default: begin
                end
            endcase
        end

        if (heartbeat_counter == 26'd49_999_999) begin
            heartbeat_counter <= 26'd0;
            heartbeat_state <= ~heartbeat_state;
        end else begin
            heartbeat_counter <= heartbeat_counter + 26'd1;
        end

        s_axi_awready <= !aw_pending && !s_axi_bvalid;
        s_axi_wready  <= !w_pending && !s_axi_bvalid;
        s_axi_arready <= !s_axi_rvalid && !snapshot_read_pending;

        if (aw_hs) begin
            awaddr_reg <= s_axi_awaddr;
            aw_pending <= 1'b1;
        end

        if (w_hs) begin
            wdata_reg <= s_axi_wdata;
            wstrb_reg <= s_axi_wstrb;
            w_pending <= 1'b1;
        end

        if (write_commit) begin
            case (write_addr)
                REG_SYS_CTRL:
                    sys_ctrl_reg <= apply_wstrb(sys_ctrl_reg, write_data, write_strb);
                REG_IO_MODE:
                    io_mode_reg <= apply_wstrb(io_mode_reg, write_data, write_strb);
                REG_IRQ_STATUS:
                    irq_status_reg <= irq_status_reg &
                                      ~apply_wstrb(32'd0, write_data, write_strb);
                REG_IRQ_ENABLE:
                    irq_enable_reg <= apply_wstrb(irq_enable_reg, write_data, write_strb);
                REG_SCRATCH:
                    scratch_reg <= apply_wstrb(scratch_reg, write_data, write_strb);
                REG_LED_CTRL:
                    led_ctrl_reg <= apply_wstrb(led_ctrl_reg, write_data, write_strb);
                REG_CAPTURE_CTRL: begin
                    if (write_strb[0] && write_data[0]) begin
                        capture_arm_pulse <= 1'b1;
                    end
                    if (write_strb[0] && write_data[1]) begin
                        capture_ack_pulse <= 1'b1;
                    end
                    if (write_strb[0] && write_data[2]) begin
                        if (virtual_enqueue_ready) begin
                            virtual_evt_valid <= 1'b1;
                            virtual_evt_trigger <= 1'b1;
                            virtual_evt_data <= {
                                timestamp_counter,
                                4'h0, 4'h0, 2'b11, 6'h02,
                                16'h0001, 8'd0, 24'd0
                            };
                        end
                    end
                end
                REG_VIRTUAL_EVENT: begin
                    if (virtual_enqueue_ready) begin
                        virtual_evt_valid <= 1'b1;
                        virtual_evt_trigger <= write_strb[3] && write_data[31];
                        virtual_evt_data <= {
                            timestamp_counter,
                            4'h0, 4'h0, 2'b11, 6'h01,
                            15'd0, (write_strb[3] && write_data[31]),
                            8'd0, write_data[23:0]
                        };
                    end
                end
                default: begin
                end
            endcase
            s_axi_bvalid <= 1'b1;
            s_axi_bresp  <= 2'b00;
            aw_pending   <= 1'b0;
            w_pending    <= 1'b0;
        end else if (s_axi_bvalid && s_axi_bready) begin
            s_axi_bvalid <= 1'b0;
        end

        if (snapshot_read_pending && snapshot_rd_valid) begin
            case (snapshot_word_select)
                2'd0: s_axi_rdata <= snapshot_rd_event[31:0];
                2'd1: s_axi_rdata <= snapshot_rd_event[63:32];
                2'd2: s_axi_rdata <= snapshot_rd_event[95:64];
                default: s_axi_rdata <= snapshot_rd_event[127:96];
            endcase
            s_axi_rresp <= 2'b00;
            s_axi_rvalid <= 1'b1;
            snapshot_read_pending <= 1'b0;
        end else if (ar_hs) begin
            if (snapshot_read_address) begin
                if (snapshot_ready &&
                    s_axi_araddr[11:4] < snapshot_count) begin
                    snapshot_rd_index <= s_axi_araddr[11:4];
                    snapshot_word_select <= s_axi_araddr[3:2];
                    snapshot_rd_en <= 1'b1;
                    snapshot_read_pending <= 1'b1;
                end else begin
                    s_axi_rdata <= 32'd0;
                    s_axi_rresp <= 2'b00;
                    s_axi_rvalid <= 1'b1;
                end
            end else begin
                if (s_axi_araddr == REG_TIMESTAMP_LO) begin
                    timestamp_shadow <= timestamp_counter;
                end
                s_axi_rdata <= read_register(s_axi_araddr);
                s_axi_rresp <= 2'b00;
                s_axi_rvalid <= 1'b1;
            end
        end else if (s_axi_rvalid && s_axi_rready) begin
            s_axi_rvalid <= 1'b0;
        end
    end
end

endmodule
