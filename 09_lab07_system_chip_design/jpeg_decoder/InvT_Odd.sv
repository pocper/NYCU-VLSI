/*************************************************************************/
// PCT-Inv_Odd: 
/*************************************************************************/
module T_Inv_Odd(ai,bi,ci,di,clk,ao,bo,co,doo);

input	clk;
input signed[15:0] 	ai,bi,ci,di;
output logic signed [15:0]	ao,bo,co,doo;
logic signed [15:0] a, b, c, d;

always_comb begin
	a = ai;
	b = bi;
	c = ci;
	d = di;

    b = b + d;
    a = a - c;
    d = d - (b>>>1);
    c = c + ((a+1)>>>1);
    a = a - ((3*b+4)>>>3);
    b = b + ((3*a+4)>>>3);
    c = c - ((3*d+4)>>>3);
    d = d + ((3*c+4)>>>3);
    c = c - ((b+1)>>>1);
    d = ((a+1)>>>1)-d;
    b = b + c;
    a = a - d;
end

always_ff @(posedge clk) begin
	ao <= a;
	bo <= b;
	co <= c;
	doo <= d;
end

endmodule