/*************************************************************************/
// postfilter:
/*************************************************************************/

`include "i_fwdrotate.sv"
// `include "T_h.sv"
`include "i_odd_oddpre.sv"
`include "i_fwdscale.sv"
`include "i_t_hpre.sv"


module  postfilter(clk,ai,bi,ci,di,ei,fi,gi,hi,ii,ji,ki,li,mi,ni,oi,pi,
ao,bo,co,doo,eo,fo,go,ho,io,jo,ko,lo,mo,no,oo,po);

input signed [15:0] ai,bi,ci,di,ei,fi,gi,hi,ii,ji,ki,li,mi,ni,oi,pi;

input clk;

output logic signed [15:0] ao,bo,co,doo,eo,fo,go,ho,io,jo,ko,lo,mo,no,oo,po;

logic signed [15:0] a_w,b_w,c_w,d_w,e_w,f_w,g_w,h_w,i_w,j_w,k_w,l_w,m_w,n_w,o_w,p_w,
a_w1,b_w1,c_w1,d_w1,e_w1,f_w1,g_w1,h_w1,i_w1,j_w1,k_w1,l_w1,m_w1,n_w1,o_w1,p_w1,
p_w2,o_w2,l_w2,k_w2;

T_h p1 (.ai(fi),.bi(gi),.ci(ji),.di(ki),.clk(clk),.ao(f_w),.bo(g_w),.co(j_w),.doo(k_w));
T_h p2 (.ai(ei),.bi(hi),.ci(ii),.di(li),.clk(clk),.ao(e_w),.bo(h_w),.co(i_w),.doo(l_w));
T_h p3 (.ai(bi),.bi(ci),.ci(ni),.di(oi),.clk(clk),.ao(b_w),.bo(c_w),.co(n_w),.doo(o_w));
T_h p4 (.ai(ai),.bi(di),.ci(mi),.di(pi),.clk(clk),.ao(a_w),.bo(d_w),.co(m_w),.doo(p_w));

i_fwdrotate p5 (.ai(n_w),.bi(m_w),.clk(clk),.ao(n_w1),.bo(m_w1));
i_fwdrotate p6 (.ai(j_w),.bi(i_w),.clk(clk),.ao(j_w1),.bo(i_w1));
i_fwdrotate p7 (.ai(h_w),.bi(d_w),.clk(clk),.ao(h_w1),.bo(d_w1));
i_fwdrotate p8 (.ai(g_w),.bi(c_w),.clk(clk),.ao(g_w1),.bo(c_w1));
i_odd_oddpre p9 (.ai(k_w),.bi(l_w),.ci(o_w),.di(p_w),.clk(clk),.ao(k_w1),.bo(l_w1),.co(o_w1),.doo(p_w1));

i_fwdscale p10 (.ai(a_w),.bi(p_w1),.clk(clk),.ao(a_w1),.bo(p_w2));
i_fwdscale p11 (.ai(b_w),.bi(l_w1),.clk(clk),.ao(b_w1),.bo(l_w2));
i_fwdscale p12 (.ai(e_w),.bi(o_w1),.clk(clk),.ao(e_w1),.bo(o_w2));
i_fwdscale p13 (.ai(f_w),.bi(k_w1),.clk(clk),.ao(f_w1),.bo(k_w2));

i_t_hpre  p14 (.ai(a_w1),.bi(m_w1),.ci(d_w1),.di(p_w2),.clk(clk),.ao(ao),.bo(mo),.co(doo),.doo(po));
i_t_hpre  p15 (.ai(b_w1),.bi(n_w1),.ci(c_w1),.di(o_w2),.clk(clk),.ao(bo),.bo(no),.co(co),.doo(oo));
i_t_hpre  p16 (.ai(e_w1),.bi(i_w1),.ci(h_w1),.di(l_w2),.clk(clk),.ao(eo),.bo(io),.co(ho),.doo(lo));
i_t_hpre  p17 (.ai(f_w1),.bi(j_w1),.ci(g_w1),.di(k_w2),.clk(clk),.ao(fo),.bo(jo),.co(go),.doo(ko));

endmodule