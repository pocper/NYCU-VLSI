module i_odd_oddpre(ai,bi,ci,di,clk,ao,bo,co,doo);

input	clk;
input signed[15:0] 	ai,bi,ci,di;
output logic signed [15:0]	ao,bo,co,doo;
logic signed [15:0] a, b, c, d, t1, t2;

always_comb begin
	a = ai;
	b = bi;
	c = ci;
	d = di;

    d = d + a;
    c = c - b;
    t1 = (d>>>1);
    t2 = (c>>>1);
    a = a - t1;
    b = b + t2;
    a = a - ((b*3+6)>>>3);
    b = b + ((a*3+2)>>>2);
    a = a - ((b*3+4)>>>3);
    b = b - t2;
    a = a + t1;
    c = c + b;
    d = d - a;
end

always_ff @(posedge clk) begin
	ao <= a;
	bo <= b;
	co <= c;
	doo <= d;
end

endmodule