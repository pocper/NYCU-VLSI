module i_t_hpre(ai,bi,ci,di,clk,ao,bo,co,doo);

input	clk;
input signed[15:0] 	ai,bi,ci,di;
output logic signed [15:0]	ao,bo,co,doo;
logic signed [15:0] a, b, c, d;

always_comb begin
	a = ai;
	b = bi;
	c = ci;
	d = di;

    b = b - c;
    a = a + ((d*3+4)>>>3);
    d = d - (b>>>1);
    c = ((a-b)>>>1)-c;
    a = a - c;
    b = b + d;   
end

always_ff @(posedge clk) begin
	ao <= a;
	bo <= b;
	co <= c;
	doo <= d;
end

endmodule