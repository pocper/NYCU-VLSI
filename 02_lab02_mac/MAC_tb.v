`timescale 1ns/1ps

module MAC_tb();
reg clk, rst_n, set;
reg  [31:0]x, b, a_in;
wire [63:0]a;
reg [63:0] a_q;
MAC u1(clk, rst_n, set, a, a_in, x, b);

always #5 clk = ~clk;

initial begin
    $dumpfile("MAC_sim.vcd");
    $dumpvars;
end

initial begin
    // Initialize circuit
    force clk = 0;
    rst_n = 0; set = 0;
    x = 0; b = 0; a_in = 0;
    #10; rst_n = 1; 
    release clk;

    // Lab2.1 MAC circuit design
    $display("Lab 2.1: Checking the correctness of MAC Circuit");
    set = 1; a_in = 1;
    #10; set = 0; 
    x = 5; b = 22;
    #10;
    $display("%3d * %3d + %3d = %3d (Expected: %3d)", a_q, x, b, a, a_q*x+b);
    
    b = 10;
    #10;
    $display("%3d * %3d + %3d = %3d (Expected: %3d)\n", a_q, x, b, a, a_q*x+b);

    // Lab2.2 MAC circuit calculate polynomial
    $display("Lab 2.2 : Checking the polynomial, f(x) = x^3+2x^2+x+1 = [(x+2)x+1]+1");
    set = 1; a_in = 1;
    #10; set = 0;
    // f(x) = x^3+2x^2+x+1 = ((x+2)x+1)x+1
    // f(x=5) = 5^3 + 2*5^2 + 5 + 1 = 181
    x = 5; b = 2;
    $display("x = %1d", x);
    #10;
    $display("x+2                    = %3d (Expected: %3d)", a, x+2);
    
    b = 1;
    #10;
    $display("(x+2)x+1               = %3d (Expected: %3d)", a, (x+2)*x+1);
    
    b = 1;
    #10;
    $display("f(x) = ((x+2)*x+1)*x+1 = %3d (Expected: %3d)", a, ((x+2)*x+1)*x+1);
    $finish;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        a_q <= 0;
    end
    else begin
        a_q <= a;
    end
end
endmodule