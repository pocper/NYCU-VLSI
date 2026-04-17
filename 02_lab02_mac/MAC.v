module MAC(clk, rst_n, set, a, a_in, x, b);
input clk, rst_n, set;
input [31:0]x, b, a_in;
output reg [63:0]a;

always @(posedge clk, negedge rst_n, posedge set) begin
    if(set) a <= a_in;
    else if(!rst_n) a <= 0;
    else a <= a * x + b;
end
endmodule