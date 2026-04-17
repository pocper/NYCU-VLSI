/*************************************************************************/
// Dequantization: 
/*************************************************************************/
`include "cal_dequan.sv"

module dequan(clk,ai,bi,ci,di,ei,fi,gi,hi,ii,ji,ki,li,mi,ni,oi,pi,
ao,bo,co,doo,eo,fo,go,ho,io,jo,ko,lo,mo,no,oo,po);

input 	clk;
input signed [7:0] ai,bi,ci,di,ei,fi,gi,hi,ii,ji,ki,li,mi,ni,oi,pi;
output logic signed [15:0] ao,bo,co,doo,eo,fo,go,ho,io,jo,ko,lo,mo,no,oo,po;


logic signed [15:0] ar,br,cr,dr,er,fr,gr,hr,ir,jr,kr,lr,mr,nr,o_r,pr;

//suppose the quantization matrix is [16 11 10 16;12 12 14 19;14 13 16 24;14 17 22 29]
parameter QPa=8'b00010000,QPb=8'b00001011,QPc=8'b00001010,QPd=8'b00010000;
parameter QPe=8'b00001100,QPf=8'b00001100,QPg=8'b00001110,QPh=8'b00010011;
parameter QPi=8'b00001110,QPj=8'b00001101,QPk=8'b00010000,QPl=8'b00011000;
parameter QPm=8'b00001110,QPn=8'b00010001,QPo=8'b00010110,QPp=8'b00011101;


cal_dequan    cala(.clk(clk), .QP(QPa), .data_i(ai), .data_o(ar));
cal_dequan    calb(.clk(clk), .QP(QPb), .data_i(bi), .data_o(br));
cal_dequan    calc(.clk(clk), .QP(QPc), .data_i(ci), .data_o(cr));
cal_dequan    cald(.clk(clk), .QP(QPd), .data_i(di), .data_o(dr));
cal_dequan    cale(.clk(clk), .QP(QPe), .data_i(ei), .data_o(er));
cal_dequan    calf(.clk(clk), .QP(QPf), .data_i(fi), .data_o(fr));
cal_dequan    calg(.clk(clk), .QP(QPg), .data_i(gi), .data_o(gr));
cal_dequan    calh(.clk(clk), .QP(QPh), .data_i(hi), .data_o(hr));
cal_dequan    cali(.clk(clk), .QP(QPi), .data_i(ii), .data_o(ir));
cal_dequan    calj(.clk(clk), .QP(QPj), .data_i(ji), .data_o(jr));
cal_dequan    calk(.clk(clk), .QP(QPk), .data_i(ki), .data_o(kr));
cal_dequan    call(.clk(clk), .QP(QPl), .data_i(li), .data_o(lr));
cal_dequan    calm(.clk(clk), .QP(QPm), .data_i(mi), .data_o(mr));
cal_dequan    caln(.clk(clk), .QP(QPn), .data_i(ni), .data_o(nr));
cal_dequan    calo(.clk(clk), .QP(QPo), .data_i(oi), .data_o(o_r));
cal_dequan    calp(.clk(clk), .QP(QPp), .data_i(pi), .data_o(pr));



always @(posedge clk) begin
	ao <= ar;
    bo <= br;
    co <= cr;
    doo <= dr;
    eo <= er;
    fo <= fr;
    go <= gr;
    ho <= hr;
    io <= ir;
    jo <= jr;
    ko <= kr;
    lo <= lr;
    mo <= mr;
    no <= nr;
    oo <= o_r;
    po <= pr;
end


endmodule


