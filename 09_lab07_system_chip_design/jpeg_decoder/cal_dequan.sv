/*************************************************************************/
// Calculate Dequantization: 
/*************************************************************************/
module cal_dequan(clk,QP,data_i,data_o);
    input clk;
	input   signed [7:0]   QP;
	input   signed [7:0]   data_i;
	output logic signed [15:0]  data_o;
	logic signed [15:0]  shift_0,shift_1,shift_2,shift_3,shift_4,shift_5,shift_6,shift_7;


always @(posedge clk) begin
	if(QP[0]==1'b1) shift_0 <= data_i;
	else 			shift_0 <= 0;
	if(QP[1]==1'b1) shift_1 <= (data_i<<1);
	else 			shift_1 <= 0;
	if(QP[2]==1'b1) shift_2 <= (data_i<<2);
	else 			shift_2 <= 0;
	if(QP[3]==1'b1) shift_3 <= (data_i<<3);
	else 			shift_3 <= 0;
	if(QP[4]==1'b1) shift_4 <= (data_i<<4);
	else 			shift_4 <= 0;	
	if(QP[5]==1'b1) shift_5 <= (data_i<<5);
	else 			shift_5 <= 0;
	if(QP[6]==1'b1) shift_6 <= (data_i<<6);
	else 			shift_6 <= 0;	
	if(QP[7]==1'b1) shift_7 <= (data_i<<7);
	else 			shift_7 <= 0;	
end

assign data_o = shift_0+shift_1+shift_2+shift_3+shift_4+shift_5+shift_6+shift_7;

endmodule

							