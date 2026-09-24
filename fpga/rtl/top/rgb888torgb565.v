
module rgb888torgb565(
    input [23:0] rgb888_data,
    output [15:0]rgb565_data
 );
    wire [4:0]r_data;
    wire [5:0]g_data;
    wire [4:0]b_data;
    
    assign r_data = rgb888_data[23:19];
    assign g_data = rgb888_data[15:10];
    assign b_data = rgb888_data[ 7: 3];
    
    assign rgb565_data = {r_data,g_data,b_data};
    
endmodule