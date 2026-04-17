`timescale 1ns / 1ps

module ALU_tb ();
reg clk, rst_n;
reg [2:0]sel;
reg [63:0]B, C;
wire [63:0]A;
reg [3:0] ID [15:0];
reg [4:0]i;
ALU #(.DW(64)) u1(clk, rst_n, A, B, C, sel);

initial begin
    $dumpfile("ALU_sim.vcd");
    $dumpvars;
end

initial begin
    forever begin
        #5; clk = ~clk;
    end
end

initial begin
    ID[0] = 4'h3;
    ID[1] = 4'h1;
    ID[2] = 4'h2;
    ID[3] = 4'h6;
    ID[4] = 4'h1;
    ID[5] = 4'h1;
    ID[6] = 4'h0;
    ID[7] = 4'h9;
    ID[8] = 4'h6;
end

initial begin
    clk = 1; rst_n = 0;
    B = 0; C = 0; sel = 0;
    #10; rst_n = 1;
    for (i = 0; i < 9; i = i + 1) begin
        C = ID[i];
        #10;
        sel = 3'b010;   // calculation <= c_buf;
        #10;
        sel = 3'b011;   // A <= A + calculation;
        #10;
        sel = 3'b111;   // NOP
    end
    $finish;
end
endmodule
