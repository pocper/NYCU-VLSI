module PATTERN(
	// output signals
	clk,
	inv,
	inu,
	iny
);

output logic signed [7:0] inv[15:0];
output logic signed [7:0] inu[15:0];
output logic signed [7:0] iny[15:0];
output logic clk;

integer i;

always	#(5.0) clk = ~clk;

initial begin

	force clk = 0;
	
	#(2); 
	for (i = 0; i<16; i=i+1) begin
		inv[i] = i;
		inu[i] = i/2;
		iny[i] = 7-i/3;
	end


	#(2); release clk;

	repeat(30) @(negedge clk);	
	$finish;
end

endmodule
