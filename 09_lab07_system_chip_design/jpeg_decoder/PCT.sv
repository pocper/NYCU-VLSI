/*************************************************************************/
//       PCT: 
/*************************************************************************/

`include "InvT_Odd_Odd.sv"
`include "InvT_Odd.sv"
`include "T_h.sv"

module PCT(clk,ai,bi,ci,di,ei,fi,gi,hi,ii,ji,ki,li,mi,ni,oi,pi,
ao,bo,co,doo,eo,fo,go,ho,io,jo,ko,lo,mo,no,oo,po);
input clk;
input signed [15:0] ai,bi,ci,di,ei,fi,gi,hi,ii,ji,ki,li,mi,ni,oi,pi;
output signed [15:0] ao,bo,co,doo,eo,fo,go,ho,io,jo,ko,lo,mo,no,oo,po;

logic signed [15:0] a_w,b_w,c_w,d_w,e_w,f_w,g_w,h_w,i_w,j_w,k_w,l_w,m_w,n_w,o_w,p_w;
// logic [15:0] a_w1,b_w1,c_w1,d_w1,e_w1,f_w1,g_w1,h_w1,i_w1,j_w1,k_w1,l_w1,m_w1,n_w1,o_w1,p_w1;

//first stage of IPCT
T_h	Th0(.ai(ai),.bi(bi),.ci(ei),.di(fi),.clk(clk),.ao(a_w),.bo(b_w),.co(e_w),.doo(f_w));
T_Inv_Odd	Tio0(.ai(ci),.bi(di),.ci(gi),.di(hi),.clk(clk),.ao(c_w),.bo(d_w),.co(g_w),.doo(h_w));
T_Inv_Odd	Tio1(.ai(ii),.bi(ji),.ci(mi),.di(ni),.clk(clk),.ao(i_w),.bo(j_w),.co(m_w),.doo(n_w));
T_Inv_Odd_Odd	Too0(.ai(ki),.bi(li),.ci(oi),.di(pi),.clk(clk),.ao(k_w),.bo(l_w),.co(o_w),.doo(p_w));
	//second stage of IPCT
T_h	Th1(.ai(a_w),.bi(d_w),.ci(m_w),.di(p_w),.clk(clk),.ao(ao),.bo(doo),.co(mo),.doo(po));
T_h	Th2(.ai(f_w),.bi(g_w),.ci(j_w),.di(k_w),.clk(clk),.ao(fo),.bo(go),.co(jo),.doo(ko));
T_h	Th3(.ai(b_w),.bi(c_w),.ci(n_w),.di(o_w),.clk(clk),.ao(bo),.bo(co),.co(no),.doo(oo));
T_h	Th4(.ai(e_w),.bi(h_w),.ci(i_w),.di(l_w),.clk(clk),.ao(eo),.bo(ho),.co(io),.doo(lo));

endmodule



