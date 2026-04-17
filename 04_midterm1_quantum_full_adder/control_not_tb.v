// 312611096 黃鉦淳
`timescale 1ns / 1ps
module control_not_tb();
reg a, b, cin;
wire and_ab;
wire cout, sum;
control_not2 u1(a, b, out);
control_not2 u2(out, cin, sum);
control_not3 u3(a, b, 1'b0, and_ab);
control_not3 u4(out, cin, and_ab, cout);

initial begin
    a = 0; b = 0; cin = 0;
    #10; a = 0; b = 0; cin = 1;
    #10; a = 0; b = 1; cin = 0;
    #10; a = 0; b = 1; cin = 1;
    #10; a = 1; b = 0; cin = 0;
    #10; a = 1; b = 0; cin = 1;
    #10; a = 1; b = 1; cin = 0;
    #10; a = 1; b = 1; cin = 1;
    #10; $finish;
end
endmodule

module control_not2(a, b, Dout);
input a, b;
output Dout;
assign Dout = (a)?(~b):b;
endmodule

module control_not3(a, b, c, Dout);
input a, b, c;
output Dout;
assign Dout = (a&b)?(~c):c;
endmodule
