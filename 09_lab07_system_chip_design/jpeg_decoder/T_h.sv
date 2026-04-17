
module T_h(ai,bi,ci,di,clk,ao,bo,co,doo);

input	clk;
input signed [15:0] ai,bi,ci,di;
output logic signed [15:0]	ao,bo,co,doo;
logic signed [15:0] a, b, c, d, t1, t2;

always_comb begin
	a = ai;
	b = bi;
	c = ci;
	d = di;

    a = a + d;
    b = b - c;
    t1 = ((a-b)>>>1);
    t2 = c;
    c = t1-d;
    d = t1-t2;
    a = a - d;
    b = b + c;
end

always_ff @(posedge clk) begin
	ao <= a;
	bo <= b;
	co <= c;
	doo <= d;
end

endmodule