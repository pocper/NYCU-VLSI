//yuv   rgb
module YUV_RGB(clk,
y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,
u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15,u16,
v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,
r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,
g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,
b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16);

input clk;
input logic signed [15:0]
y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,
u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15,u16,
v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16;

output logic signed [15:0] 
r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,
g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,
b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16;

logic signed [15:0] 
yr1,yr2,yr3,yr4,yr5,yr6,yr7,yr8,yr9,yr10,yr11,yr12,yr13,yr14,yr15,yr16,
ur1,ur2,ur3,ur4,ur5,ur6,ur7,ur8,ur9,ur10,ur11,ur12,ur13,ur14,ur15,ur16,
vr1,vr2,vr3,vr4,vr5,vr6,vr7,vr8,vr9,vr10,vr11,vr12,vr13,vr14,vr15,vr16,

gr1,gr2,gr3,gr4,gr5,gr6,gr7,gr8,gr9,gr10,gr11,gr12,gr13,gr14,gr15,gr16,
rr1,rr2,rr3,rr4,rr5,rr6,rr7,rr8,rr9,rr10,rr11,rr12,rr13,rr14,rr15,rr16,
br1,br2,br3,br4,br5,br6,br7,br8,br9,br10,br11,br12,br13,br14,br15,br16,

urs1,urs2,urs3,urs4,urs5,urs6,urs7,urs8,urs9,urs10,urs11,urs12,urs13,urs14,urs15,urs16,
vrs1,vrs2,vrs3,vrs4,vrs5,vrs6,vrs7,vrs8,vrs9,vrs10,vrs11,vrs12,vrs13,vrs14,vrs15,vrs16;


always @(posedge clk)  begin
	yr1 = y1;
	yr2 = y2;
	yr3 = y3;
	yr4 = y4;
	yr5 = y5;
	yr6 = y6;
	yr7 = y7;
	yr8 = y8;
	yr9 = y9;
	yr10 = y10;
	yr11 = y11;
	yr12 = y12;
	yr13 = y13;
	yr14 = y14;
	yr15 = y15;
	yr16 = y16;
	ur1 = u1;
	ur2 = u2;
	ur3 = u3;
	ur4 = u4;
	ur5 = u5;
	ur6 = u6;
	ur7 = u7;
	ur8 = u8;
	ur9 = u9;
	ur10 = u10;
	ur11 = u11;
	ur12 = u12;
	ur13 = u13;
	ur14 = u14;
	ur15 = u15;
	ur16 = u16;
	vr1 = v1;
	vr2 = v2;
	vr3 = v3;
	vr4 = v4;
	vr5 = v5;
	vr6 = v6;
	vr7 = v7;
	vr8 = v8;
	vr9 = v9;
	vr10 = v10;
	vr11 = v11;
	vr12 = v12;
	vr13 = v13;
	vr14 = v14;
	vr15 = v15;
	vr16 = v16;


	urs1 = ur1 >>> 1 ;
	urs2 = ur2 >>> 1 ;
	urs3 = ur3 >>> 1 ;
	urs4 = ur4 >>> 1 ;
	urs5 = ur5 >>> 1 ;
	urs6 = ur6 >>> 1 ;
	urs7 = ur7 >>> 1 ;
	urs8 = ur8 >>> 1 ;
	urs9 = ur9 >>> 1 ;
	urs10 = ur10 >>> 1 ;
	urs11 = ur11 >>> 1 ;
	urs12 = ur12 >>> 1 ;
	urs13 = ur13 >>> 1 ;
	urs14 = ur14 >>> 1 ;
	urs15 = ur15 >>> 1 ;
	urs16 = ur16 >>> 1 ;

	gr1 = yr1 - urs1;
	gr2 = yr2 - urs2;
	gr3 = yr3 - urs3;
	gr4 = yr4 - urs4;
	gr5 = yr5 - urs5;
	gr6 = yr6 - urs6;
	gr7 = yr7 - urs7;
	gr8 = yr8 - urs8;
	gr9 = yr9 - urs9;
	gr10 = yr10 - urs10;
	gr11 = yr11 - urs11;
	gr12 = yr12 - urs12;
	gr13 = yr13 - urs13;
	gr14 = yr14 - urs14;
	gr15 = yr15 - urs15;
	gr16 = yr16 - urs16;

	vrs1 = vr1 >>> 1 ;
	vrs2 = vr2 >>> 1 ;
	vrs3 = vr3 >>> 1 ;
	vrs4 = vr4 >>> 1 ;
	vrs5 = vr5 >>> 1 ;
	vrs6 = vr6 >>> 1 ;
	vrs7 = vr7 >>> 1 ;
	vrs8 = vr8 >>> 1 ;
	vrs9 = vr9 >>> 1 ;
	vrs10 = vr10 >>> 1 ;
	vrs11 = vr11 >>> 1 ;
	vrs12 = vr12 >>> 1 ;
	vrs13 = vr13 >>> 1 ;
	vrs14 = vr14 >>> 1 ;
	vrs15 = vr15 >>> 1 ;
	vrs16 = vr16 >>> 1 ;

	rr1 = ur1 - vrs1 + gr1;
	rr2 = ur2 - vrs2 + gr2;
	rr3 = ur3 - vrs3 + gr3;
	rr4 = ur4 - vrs4 + gr4;
	rr5 = ur5 - vrs5 + gr5;
	rr6 = ur6 - vrs6 + gr6;
	rr7 = ur7 - vrs7 + gr7;
	rr8 = ur8 - vrs8 + gr8;
	rr9 = ur9 - vrs9 + gr9;
	rr10 = ur10 - vrs10 + gr10;
	rr11 = ur11 - vrs11 + gr11;
	rr12 = ur12 - vrs12 + gr12;
	rr13 = ur13 - vrs13 + gr13;
	rr14 = ur14 - vrs14 + gr14;
	rr15 = ur15 - vrs15 + gr15;
	rr16 = ur16 - vrs16 + gr16;

	br1 = vr1 + rr1;
	br2 = vr2 + rr2;
	br3 = vr3 + rr3;
	br4 = vr4 + rr4;
	br5 = vr5 + rr5;
	br6 = vr6 + rr6;
	br7 = vr7 + rr7;
	br8 = vr8 + rr8;
	br9 = vr9 + rr9;
	br10 = vr10 + rr10;
	br11 = vr11 + rr11;
	br12 = vr12 + rr12;
	br13 = vr13 + rr13;
	br14 = vr14 + rr14;
	br15 = vr15 + rr15;
	br16 = vr16 + rr16; 
end

always_ff @(posedge clk) begin
	r1 <= rr1;
	r2 <= rr2;
	r3 <= rr3;
	r4 <= rr4;
	r5 <= rr5;
	r6 <= rr6;
	r7 <= rr7;
	r8 <= rr8;
	r9 <= rr9;
	r10 <= rr10;
	r11 <= rr11;
	r12 <= rr12;
	r13 <= rr13;
	r14 <= rr14;
	r15 <= rr15;
	r16 <= rr16;	
	g1 <= gr1;
	g2 <= gr2;
	g3 <= gr3;
	g4 <= gr4;
	g5 <= gr5;
	g6 <= gr6;
	g7 <= gr7;
	g8 <= gr8;
	g9 <= gr9;
	g10 <= gr10;
	g11 <= gr11;
	g12 <= gr12;
	g13 <= gr13;
	g14 <= gr14;
	g15 <= gr15;
	g16 <= gr16;	
	b1 <= br1;
	b2 <= br2;
	b3 <= br3;
	b4 <= br4;
	b5 <= br5;
	b6 <= br6;
	b7 <= br7;
	b8 <= br8;
	b9 <= br9;
	b10 <= br10;
	b11 <= br11;
	b12 <= br12;
	b13 <= br13;
	b14 <= br14;
	b15 <= br15;
	b16 <= br16;
end

endmodule  