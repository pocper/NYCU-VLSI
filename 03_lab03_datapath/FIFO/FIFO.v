`timescale 1ns / 1ps

// parameter
// AW : Address Width
// DW : Data Width
module FIFO #(parameter AW = 4, DW = 4)
    (wclk, rclk, wrst_n, rrst_n, EN_w, EN_r, wdata, rdata, full, empty);
localparam DP = 1<<AW; // DEPTH = 16
input wclk, rclk;
input wrst_n, rrst_n;
input EN_w, EN_r;
input  [DW-1:0]wdata;
output [DW-1:0]rdata;
output full, empty;

wire [AW:0]rptr_b, wptr_b;
wire [AW:0]rptr_g, wptr_g;
wire [AW:0]rptr_g_sync, wptr_g_sync;
wire [DW-1:0] Dout_A; // there's no meaning just satisfy DPRAM

wire EN_w_RAM, EN_r_RAM;
Handler_wptr #(.AW(AW))          u1(wclk, wrst_n, wptr_b, wptr_g, rptr_g_sync, EN_w, EN_w_RAM, full);
Handler_rptr #(.AW(AW))          u2(rclk, rrst_n, rptr_b, rptr_g, wptr_g_sync, EN_r, EN_r_RAM, empty);
Synchronizer #(.AW(AW))          u3(rclk, rrst_n, wptr_g, wptr_g_sync);
Synchronizer #(.AW(AW))          u4(wclk, wrst_n, rptr_g, rptr_g_sync);
DPRAM        #(.AW(AW), .DW(DW)) u5(wclk, rclk, EN_w_RAM, EN_r_RAM, 1'b1, 1'b0, wptr_b[AW-1:0], rptr_b[AW-1:0], wdata, {DW{1'b0}}, Dout_A, rdata);
endmodule

// module : Handler_wptr
// Description : Handling FIFO with wclk whether RAM is full or not
module Handler_wptr #(parameter AW = 4)
    (wclk, wrst_n, wptr_b, wptr_g, rptr_g_sync, EN_w, EN_w_RAM, full);
input wclk, wrst_n, EN_w;
input      [AW:0] rptr_g_sync;
output            EN_w_RAM;
output reg        full;
output reg [AW:0] wptr_b;
output     [AW:0] wptr_g;
wire isFIFOFull;
assign isFIFOFull = (wptr_g[AW:AW-1] == ~rptr_g_sync[AW:AW-1]) && (wptr_g[AW-2:0] == rptr_g_sync[AW-2:0]);
assign EN_w_RAM = (EN_w & !isFIFOFull);
Converter_Bin2Gray #(.AW(AW)) Converter_B2G (wptr_g, wptr_b);

always @(posedge wclk, negedge wrst_n) begin
    if(!wrst_n) begin
        wptr_b <= 0;
        full <= 0;
    end
    else begin
        wptr_b <= wptr_b + EN_w_RAM;
        full <= isFIFOFull;
    end
end
endmodule

// module : Handler_rptr
// Description : Handling FIFO with rclk whether RAM is empty or not
module Handler_rptr #(parameter AW = 4)
    (rclk, rrst_n, rptr_b, rptr_g, wptr_g_sync, EN_r, EN_r_RAM, empty);
input rclk, rrst_n, EN_r;
input      [AW:0] wptr_g_sync;
output            EN_r_RAM;
output reg        empty;
output reg [AW:0] rptr_b;
output     [AW:0] rptr_g;
wire isFIFOEmpty;
assign isFIFOEmpty = (rptr_g == wptr_g_sync);
assign EN_r_RAM = (EN_r & !isFIFOEmpty);
Converter_Bin2Gray #(.AW(AW)) Converter_B2G (rptr_g, rptr_b);

always @(posedge rclk, negedge rrst_n) begin
    if(!rrst_n) begin
        rptr_b <= 0;
        empty <= 1;
    end
    else begin
        rptr_b <= rptr_b + EN_r_RAM;
        empty <= isFIFOEmpty;
    end
end
endmodule

// module : Synchronizer
// Description : Stabilizing pointer from FIFO handler
module Synchronizer #(parameter AW = 4)
    (clk, rst_n, Din, Dout);
input clk, rst_n;
input      [AW:0] Din;
output reg [AW:0] Dout;
reg        [AW:0] din1;

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        din1 <= 0;
        Dout <= 0;
    end
    else begin
        din1 <= Din;
        Dout <= din1;
    end
end
endmodule

// module : Dual-Port RAM
module DPRAM #(parameter AW = 4, DW = 4)
    (clk_A, clk_B, EN_A, EN_B, WE_A, WE_B, addr_A, addr_B, Din_A, Din_B, Dout_A, Dout_B);
    input               clk_A, clk_B;
    input               EN_A, EN_B;
    input               WE_A, WE_B;
    input      [AW-1:0] addr_A, addr_B;
    input      [DW-1:0] Din_A, Din_B;
    output reg [DW-1:0] Dout_A, Dout_B;

    localparam DP = 1<<AW; // Depth
    reg [DW-1:0] RAM[0:DP-1]; // DATAWIDTH = 4, DEPTH = 16
    
    always @(posedge clk_A) begin
        if(EN_A) begin
            if(WE_A) RAM[addr_A] <= Din_A;
            Dout_A <= RAM[addr_A];
        end
    end

    always @(posedge clk_B) begin
        if(EN_B) begin
            if(WE_B) RAM[addr_B] <= Din_B;
            Dout_B <= RAM[addr_B];
        end
    end
endmodule

// module : Converter_Bin2Gray
// Description : change binary to gray code
module Converter_Bin2Gray #(parameter AW = 4)
    (gray, bin);
input      [AW:0] bin;
output reg [AW:0] gray;
reg signed [AW:0] i;
always @(*) begin
    // MSB of gray code = MSB of binary
    gray[AW] = bin[AW];
    for (i = AW-1; i >= 0; i = i - 1)
        gray[i] = bin[i] ^ bin[i+1];
end
endmodule

// module : Converter_Gray2Bin
// Description : change gray code to binary
module Converter_Gray2Bin #(parameter AW = 4)
    (bin, gray);
input      [AW:0] gray;
output reg [AW:0] bin;
reg signed [AW:0] i;
always @(*) begin
    // MSB of binary = MSB of gray code
    bin[AW] = gray[AW];
    for (i = AW-1; i >= 0; i = i - 1)
        bin[i] = gray[i] ^ bin[i+1];
end
endmodule