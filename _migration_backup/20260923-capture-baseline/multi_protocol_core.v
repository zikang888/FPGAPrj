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
    output wire         led_heartbeat,
    output wire         led_ps_active
);

localparam [31:0] SYS_ID_VALUE       = 32'h4D50_5254; // "MPRT"
localparam [31:0] VERSION_VALUE      = 32'h0001_0000; // 1.0.0
localparam [31:0] BUILD_ID_VALUE     = 32'h2026_0922;
localparam [31:0] CAPABILITIES_VALUE = 32'h0000_0000;

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

reg [31:0] sys_ctrl_reg;
reg [31:0] io_mode_reg;
reg [31:0] irq_status_reg;
reg [31:0] irq_enable_reg;
reg [31:0] scratch_reg;
reg [31:0] led_ctrl_reg;

reg [63:0] timestamp_counter;
reg [63:0] timestamp_shadow;
reg [25:0] heartbeat_counter;
reg        heartbeat_state;

reg [15:0] awaddr_reg;
reg [31:0] wdata_reg;
reg [3:0]  wstrb_reg;
reg        aw_pending;
reg        w_pending;

wire aw_hs = s_axi_awvalid && s_axi_awready;
wire w_hs  = s_axi_wvalid && s_axi_wready;
wire write_commit = !s_axi_bvalid &&
                    (aw_pending || aw_hs) &&
                    (w_pending || w_hs);
wire [15:0] write_addr = aw_pending ? awaddr_reg : s_axi_awaddr;
wire [31:0] write_data = w_pending ? wdata_reg : s_axi_wdata;
wire [3:0]  write_strb = w_pending ? wstrb_reg : s_axi_wstrb;

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
            default:          read_register = 32'h0000_0000;
        endcase
    end
endfunction

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
        timestamp_counter <= 64'd0;
        timestamp_shadow <= 64'd0;
        heartbeat_counter <= 26'd0;
        heartbeat_state  <= 1'b0;
    end else begin
        timestamp_counter <= timestamp_counter + 64'd1;

        if (heartbeat_counter == 26'd49_999_999) begin
            heartbeat_counter <= 26'd0;
            heartbeat_state <= ~heartbeat_state;
        end else begin
            heartbeat_counter <= heartbeat_counter + 26'd1;
        end

        s_axi_awready <= !aw_pending && !s_axi_bvalid;
        s_axi_wready  <= !w_pending && !s_axi_bvalid;
        s_axi_arready <= !s_axi_rvalid;

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

        if (!s_axi_rvalid && s_axi_arvalid) begin
            if (s_axi_araddr == REG_TIMESTAMP_LO) begin
                timestamp_shadow <= timestamp_counter;
            end
            s_axi_rdata  <= read_register(s_axi_araddr);
            s_axi_rresp  <= 2'b00;
            s_axi_rvalid <= 1'b1;
        end else if (s_axi_rvalid && s_axi_rready) begin
            s_axi_rvalid <= 1'b0;
        end
    end
end

endmodule
