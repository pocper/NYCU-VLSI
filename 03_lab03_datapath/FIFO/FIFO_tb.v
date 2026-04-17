`timescale 1ns / 1ps

module FIFO_tb #(parameter AW = 4, DW = 4)();
reg wclk, rclk;
reg wrst_n, rrst_n;
reg EN_w, EN_r;
reg  [DW-1:0]wdata;
wire [DW-1:0]rdata;
wire full, empty;
FIFO #(.AW(AW), .DW(DW)) u1(wclk, rclk, wrst_n, rrst_n, EN_w, EN_r, wdata, rdata, full, empty);
localparam DP = 1<<DW; // DEPTH
reg [DW-1:0] ID [15:0];
reg [4:0]i;

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
    $dumpfile("FIFO_sim.vcd");
    $dumpvars;
end

initial begin
    forever begin
        #5; wclk = ~wclk; // 100MHz
    end
end

initial begin
    wclk = 1; wrst_n = 0; 
    EN_w = 0; wdata = 0;
    @(posedge wclk);
    wrst_n = 1;
    for (i=0; i<9;i=i+1) begin
        EN_w = 1; wdata = ID[i];
        @(posedge wclk);
        EN_w = 0;
        @(posedge wclk); // prevent racing in DPRAM
    end
    @(posedge wclk);
    EN_w = 0;
    $finish;
end

initial begin
    forever begin
        #10; rclk = ~rclk; // 25MHz
    end
end

initial begin
    rclk = 1; rrst_n = 0;
    EN_r = 0;
    #20; rrst_n = 1;
    #200; // wait for writing data into RAM
    // for (i=0; i<16;i=i+1) begin
    //     #20; EN_r = 1;
    //     $display("read data[%d] = %d\n", i, rdata);
    // end
    // #20; EN_r = 0;
    // #200;
    // for (i=0; i<16;i=i+1) begin
    //     #20; EN_r = 1;
    //     $display("read data[%d] = %d\n", i, rdata);
    // end
    // #20; EN_r = 0;
    // $finish;
end
endmodule
