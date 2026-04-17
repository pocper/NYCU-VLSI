/*************************************************************************/
// i_t_h.sv
/*************************************************************************/
module i_fwdrotate(ai,bi,clk,ao,bo);

input	clk;
input signed[15:0] 	ai,bi;
output logic signed [15:0]	ao,bo;
logic signed [15:0] a, b;

always_comb begin
	a = ai;
	b = bi;
    a = a - ((b*3+8)>>>4);
    b = b + ((a*3+4)>>>3);
    a = a - ((b*3+8)>>>4);

end

always_ff @(posedge clk) begin
	ao <= a;
	bo <= b;
end

endmodule