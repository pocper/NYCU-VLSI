
`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.v"

`ifdef RTL
  `include "../01_RTL/bitcoin.v"
`endif

`ifdef GATE
  `include "../02_SYN/Netlist/bitcoin_SYN.v"
`endif


module TESTBED;
   //input
	wire [639:0] block_header;
	//output
	wire [255:0] hash_result,Block;

	
	
initial begin
  `ifdef RTL
    $fsdbDumpfile("bitcoin.fsdb");
    $fsdbDumpvars();
  `endif

end

`ifdef RTL	
bitcoin	u_bitcoin	(
		.block_header(block_header),
		.Block(Block),
		.hash_result(hash_result)
		);
`endif

`ifdef GATE
bitcoin u_bitcoin	(
		.block_header(block_header),
		.Block(Block),
		.hash_result(hash_result)
		);
`endif

PATTERN	u_PATTERN(
		.block_header(block_header),
		.Block(Block),
		.hash_result(hash_result)
		);
		
endmodule