`timescale 1ns / 1ps

module Lab3_tb #(parameter AW = 4, DW = 5)();
reg wclk, rclk;
reg wrst_n, rrst_n;
reg EN_wB, EN_rB, EN_wC, EN_rC;
reg  [DW-1:0]wB, wC;
reg  [2:0]sel;
wire [DW-1:0]rA, rB, rC;
wire full_B, empty_B;
wire full_C, empty_C;

reg [DW-1:0] ID [15:0];
reg [4:0]i, j;

FIFO #(.AW(AW), .DW(DW)) u2(wclk, rclk, wrst_n, rrst_n, EN_wB, EN_rB, wB, rB, full_B, empty_B);
FIFO #(.AW(AW), .DW(DW)) u3(wclk, rclk, wrst_n, rrst_n, EN_wC, EN_rC, wC, rC, full_C, empty_C);
ALU  #(.DW(DW))          u4(rclk, rrst_n, rA, rB, rC, sel);

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
    $dumpfile("Lab3_sim.vcd");
    $dumpvars;
end

initial begin
    forever begin
        #5; wclk = ~wclk; // 100MHz
    end
end

initial begin
    forever begin
        #10; rclk = ~rclk; // 25MHz
    end
end

initial begin
    wclk = 1; wrst_n = 0; 
    EN_wB = 0; EN_wC = 0;
    wB = 0; wC = 0;
    @(posedge wclk);
    wrst_n = 1;
    for (i = 0; i < 9; i = i + 1) begin
        while (full_C) @(posedge wclk);
        EN_wC = 1; wC = ID[i];
        @(posedge wclk);
        EN_wC = 0;
        @(posedge wclk); // prevent racing in DPRAM
    end
end

initial begin
    rclk = 1; rrst_n = 0;
    EN_rB = 0; EN_rC = 0; sel = 0;
    @(posedge rclk);
    rrst_n = 1; sel = 3'b010; // calculation <= C_buf;
    while(empty_C) @(posedge rclk); // wait for first data transfer into FIFO
    EN_rC = 1;
    while (!empty_C) @(posedge rclk); // wait for data
    EN_rC = 0;
    // Pipeline need to wait for data pass through (3-1) FF
    repeat(2) @(posedge rclk);
    $finish;
end
endmodule
