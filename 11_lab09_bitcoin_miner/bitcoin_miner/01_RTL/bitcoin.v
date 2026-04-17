
module bitcoin(block_header,hash_result,Block);

input   wire    [639:0] block_header;
output  wire    [255:0] hash_result,Block;

wire [31:0] k_data[0:63];

wire [31:0] w0[0:63], w1[0:63], w2[0:63];

wire [31:0] a0[0:64], a1[0:64], a2[0:64];
wire [31:0] b0[0:64], b1[0:64], b2[0:64];
wire [31:0] c0[0:64], c1[0:64], c2[0:64];
wire [31:0] d0[0:64], d1[0:64], d2[0:64];
wire [31:0] e0[0:64], e1[0:64], e2[0:64];
wire [31:0] f0[0:64], f1[0:64], f2[0:64];
wire [31:0] g0[0:64], g1[0:64], g2[0:64];
wire [31:0] h0[0:64], h1[0:64], h2[0:64];

wire [31:0] t1_0[0:63], t1_1[0:63], t1_2[0:63];
wire [31:0] t2_0[0:63], t2_1[0:63], t2_2[0:63];


// initialize K data, 64 constant
assign k_data[0] = 32'h428A2F98;
assign k_data[1] = 32'h71374491;
assign k_data[2] = 32'hB5C0FBCF;
assign k_data[3] = 32'hE9B5DBA5;
assign k_data[4] = 32'h3956C25B;
assign k_data[5] = 32'h59F111F1;
assign k_data[6] = 32'h923F82A4;
assign k_data[7] = 32'hAB1C5ED5;
assign k_data[8] = 32'hD807AA98;
assign k_data[9] = 32'h12835B01;
assign k_data[10] = 32'h243185BE;
assign k_data[11] = 32'h550C7DC3;
assign k_data[12] = 32'h72BE5D74;
assign k_data[13] = 32'h80DEB1FE;
assign k_data[14] = 32'h9BDC06A7;
assign k_data[15] = 32'hC19BF174;
assign k_data[16] = 32'hE49B69C1;
assign k_data[17] = 32'hEFBE4786;
assign k_data[18] = 32'h0FC19DC6;
assign k_data[19] = 32'h240CA1CC;
assign k_data[20] = 32'h2DE92C6F;
assign k_data[21] = 32'h4A7484AA;
assign k_data[22] = 32'h5CB0A9DC;
assign k_data[23] = 32'h76F988DA;
assign k_data[24] = 32'h983E5152;
assign k_data[25] = 32'hA831C66D;
assign k_data[26] = 32'hB00327C8;
assign k_data[27] = 32'hBF597FC7;
assign k_data[28] = 32'hC6E00BF3;
assign k_data[29] = 32'hD5A79147;
assign k_data[30] = 32'h06CA6351;
assign k_data[31] = 32'h14292967;
assign k_data[32] = 32'h27B70A85;
assign k_data[33] = 32'h2E1B2138;
assign k_data[34] = 32'h4D2C6DFC;
assign k_data[35] = 32'h53380D13;
assign k_data[36] = 32'h650A7354;
assign k_data[37] = 32'h766A0ABB;
assign k_data[38] = 32'h81C2C92E;
assign k_data[39] = 32'h92722C85;
assign k_data[40] = 32'hA2BFE8A1;
assign k_data[41] = 32'hA81A664B;
assign k_data[42] = 32'hC24B8B70;
assign k_data[43] = 32'hC76C51A3;
assign k_data[44] = 32'hD192E819;
assign k_data[45] = 32'hD6990624;
assign k_data[46] = 32'hF40E3585;
assign k_data[47] = 32'h106AA070;
assign k_data[48] = 32'h19A4C116;
assign k_data[49] = 32'h1E376C08;
assign k_data[50] = 32'h2748774C;
assign k_data[51] = 32'h34B0BCB5;
assign k_data[52] = 32'h391C0CB3;
assign k_data[53] = 32'h4ED8AA4A;
assign k_data[54] = 32'h5B9CCA4F;
assign k_data[55] = 32'h682E6FF3;
assign k_data[56] = 32'h748F82EE;
assign k_data[57] = 32'h78A5636F;
assign k_data[58] = 32'h84C87814;
assign k_data[59] = 32'h8CC70208;
assign k_data[60] = 32'h90BEFFFA;
assign k_data[61] = 32'hA4506CEB;
assign k_data[62] = 32'hBEF9A3F7;
assign k_data[63] = 32'hC67178F2;



// set input value of 1st time sha256 compress
assign a0[ 0] = 32'h6A09E667;
assign b0[ 0] = 32'hBB67AE85;
assign c0[ 0] = 32'h3C6EF372;
assign d0[ 0] = 32'hA54FF53A;
assign e0[ 0] = 32'h510E527F;
assign f0[ 0] = 32'h9B05688C;
assign g0[ 0] = 32'h1F83D9AB;
assign h0[ 0] = 32'h5BE0CD19;

assign w0[ 0] = block_header[ 0*32+:32]; // version
assign w0[ 1] = block_header[ 1*32+:32]; // previous block hash
assign w0[ 2] = block_header[ 2*32+:32];
assign w0[ 3] = block_header[ 3*32+:32];
assign w0[ 4] = block_header[ 4*32+:32];
assign w0[ 5] = block_header[ 5*32+:32];
assign w0[ 6] = block_header[ 6*32+:32];
assign w0[ 7] = block_header[ 7*32+:32];
assign w0[ 8] = block_header[ 8*32+:32];
assign w0[ 9] = block_header[ 9*32+:32]; // merkle root
assign w0[10] = block_header[10*32+:32];
assign w0[11] = block_header[11*32+:32];
assign w0[12] = block_header[12*32+:32];
assign w0[13] = block_header[13*32+:32];
assign w0[14] = block_header[14*32+:32];
assign w0[15] = block_header[15*32+:32];

// set input value of 2nd sha256 compress
assign a1[ 0] = a0[ 0] + a0[64];
assign b1[ 0] = b0[ 0] + b0[64];
assign c1[ 0] = c0[ 0] + c0[64];
assign d1[ 0] = d0[ 0] + d0[64];
assign e1[ 0] = e0[ 0] + e0[64];
assign f1[ 0] = f0[ 0] + f0[64];
assign g1[ 0] = g0[ 0] + g0[64];
assign h1[ 0] = h0[ 0] + h0[64];

assign w1[ 0] = block_header[16*32+:32];
assign w1[ 1] = block_header[17*32+:32]; // time
assign w1[ 2] = block_header[18*32+:32]; // bits
assign w1[ 3] = block_header[19*32+:32]; // nonce
assign w1[ 4] = 32'h80000000; // pending constant value
assign w1[ 5] = 32'h00000000;
assign w1[ 6] = 32'h00000000;
assign w1[ 7] = 32'h00000000;
assign w1[ 8] = 32'h00000000;
assign w1[ 9] = 32'h00000000;
assign w1[10] = 32'h00000000;
assign w1[11] = 32'h00000000;
assign w1[12] = 32'h00000000;
assign w1[13] = 32'h00000000;
assign w1[14] = 32'h00000000;
assign w1[15] = 32'h00000280;

// set input value of 2nd 256
assign a2[ 0] = 32'h6A09E667;
assign b2[ 0] = 32'hBB67AE85;
assign c2[ 0] = 32'h3C6EF372;
assign d2[ 0] = 32'hA54FF53A;
assign e2[ 0] = 32'h510E527F;
assign f2[ 0] = 32'h9B05688C;
assign g2[ 0] = 32'h1F83D9AB;
assign h2[ 0] = 32'h5BE0CD19;

// the result of 2nd sha256 compress is the message input of 3th sha256 compress
assign w2[ 0] = a1[ 0] + a1[64];
assign w2[ 1] = b1[ 0] + b1[64];
assign w2[ 2] = c1[ 0] + c1[64];
assign w2[ 3] = d1[ 0] + d1[64];
assign w2[ 4] = e1[ 0] + e1[64];
assign w2[ 5] = f1[ 0] + f1[64];
assign w2[ 6] = g1[ 0] + g1[64];
assign w2[ 7] = h1[ 0] + h1[64];
assign w2[ 8] = 32'h80000000; // pending constant value
assign w2[ 9] = 32'h00000000;
assign w2[10] = 32'h00000000;
assign w2[11] = 32'h00000000;
assign w2[12] = 32'h00000000;
assign w2[13] = 32'h00000000;
assign w2[14] = 32'h00000000;
assign w2[15] = 32'h00000100;

// final result
assign hash_result[ 0*32+:32] = a2[ 0] + a2[64];
assign hash_result[ 1*32+:32] = b2[ 0] + b2[64];
assign hash_result[ 2*32+:32] = c2[ 0] + c2[64];
assign hash_result[ 3*32+:32] = d2[ 0] + d2[64];
assign hash_result[ 4*32+:32] = e2[ 0] + e2[64];
assign hash_result[ 5*32+:32] = f2[ 0] + f2[64];
assign hash_result[ 6*32+:32] = g2[ 0] + g2[64];
assign hash_result[ 7*32+:32] = h2[ 0] + h2[64];


genvar i;

generate

    for ( i = 0; i < 48; i = i + 1 )
    begin: calc_w_data_48_times

        assign w0[i+16] = func_lower_case_sigma_1(w0[i+14]) + w0[i+9] + func_lower_case_sigma_0(w0[i+1]) + w0[i];
        assign w1[i+16] = func_lower_case_sigma_1(w1[i+14]) + w1[i+9] + func_lower_case_sigma_0(w1[i+1]) + w1[i];
        assign w2[i+16] = func_lower_case_sigma_1(w2[i+14]) + w2[i+9] + func_lower_case_sigma_0(w2[i+1]) + w2[i];

    end

    for ( i = 0; i < 64; i = i + 1 )
    begin: calc_a_to_h_64_times

        assign t1_0[i] = h0[i] + func_upper_case_sigma_1(e0[i]) + func_Ch(e0[i], f0[i], g0[i]) + k_data[i] + w0[i];
        assign t1_1[i] = h1[i] + func_upper_case_sigma_1(e1[i]) + func_Ch(e1[i], f1[i], g1[i]) + k_data[i] + w1[i];
        assign t1_2[i] = h2[i] + func_upper_case_sigma_1(e2[i]) + func_Ch(e2[i], f2[i], g2[i]) + k_data[i] + w2[i];

        assign t2_0[i] = func_upper_case_sigma_0(a0[i]) + func_Maj(a0[i], b0[i], c0[i]);
        assign t2_1[i] = func_upper_case_sigma_0(a1[i]) + func_Maj(a1[i], b1[i], c1[i]);
        assign t2_2[i] = func_upper_case_sigma_0(a2[i]) + func_Maj(a2[i], b2[i], c2[i]);

        assign h0[i+1] =   g0[i];
        assign g0[i+1] =   f0[i];
        assign f0[i+1] =   e0[i];
        assign e0[i+1] =   d0[i] + t1_0[i];
        assign d0[i+1] =   c0[i];
        assign c0[i+1] =   b0[i];
        assign b0[i+1] =   a0[i];
        assign a0[i+1] = t1_0[i] + t2_0[i];

        assign h1[i+1] =   g1[i];
        assign g1[i+1] =   f1[i];
        assign f1[i+1] =   e1[i];
        assign e1[i+1] =   d1[i] + t1_1[i];
        assign d1[i+1] =   c1[i];
        assign c1[i+1] =   b1[i];
        assign b1[i+1] =   a1[i];
        assign a1[i+1] = t1_1[i] + t2_1[i];

        assign h2[i+1] =   g2[i];
        assign g2[i+1] =   f2[i];
        assign f2[i+1] =   e2[i];
        assign e2[i+1] =   d2[i] + t1_2[i];
        assign d2[i+1] =   c2[i];
        assign c2[i+1] =   b2[i];
        assign b2[i+1] =   a2[i];
        assign a2[i+1] = t1_2[i] + t2_2[i];

    end

endgenerate


// below are 6 kinds operations used in sha256 compress
function [31:0] func_Ch;
    input [31:0] x;
    input [31:0] y;
    input [31:0] z;
    begin
        func_Ch =   (   x  & y )
                ^ ( (~x) & z );
    end
endfunction

function [31:0] func_Maj;
    input [31:0] x;
    input [31:0] y;
    input [31:0] z;
    begin
        func_Maj =   ( x & y )
                 ^ ( y & z )
                 ^ ( x & z );
    end
endfunction

// S2 ^ S13 ^ S22
function [31:0] func_upper_case_sigma_0;
    input [31:0] x;
    begin
        func_upper_case_sigma_0 =   {x[ 1: 0], x[31: 2]}  // S2
                                ^ {x[12: 0], x[31:13]}  // S13
                                ^ {x[21: 0], x[31:22]}; // S22
    end
endfunction

// S6 ^ S11 ^ S25
function [31:0] func_upper_case_sigma_1;
    input [31:0] x;
    begin
        func_upper_case_sigma_1 =   {x[ 5: 0], x[31: 6]}  // S6
                                ^ {x[10: 0], x[31:11]}  // S11
                                ^ {x[24: 0], x[31:25]}; // S25
    end
endfunction

// S7 ^ S18 ^ R3
function [31:0] func_lower_case_sigma_0;
    input [31:0] x;
    begin
        func_lower_case_sigma_0 =   { x[ 6: 0], x[31: 7] }  // S7
                                ^ { x[17: 0], x[31:18] }  // S18
                                ^ {     3'h0, x[31: 3] }; // R3
    end
endfunction

// S17 ^ S19 ^ R10
function [31:0] func_lower_case_sigma_1;
    input [31:0] x;
    begin
        func_lower_case_sigma_1 =   { x[16: 0], x[31:17] }  // S17
                                ^ { x[18: 0], x[31:19] }  // S19
                                ^ {    10'h0, x[31:10] }; // R10
    end
endfunction

assign Block = {hash_result[199:196],hash_result[195:192],hash_result[207:204],hash_result[203:200],hash_result[215:212],hash_result[211:208],hash_result[223:220],hash_result[219:216],hash_result[167:164],hash_result[163:160],hash_result[175:172],hash_result[171:168],hash_result[183:180],hash_result[179:176],hash_result[191:188],hash_result[187:184],hash_result[135:132],hash_result[131:128],hash_result[143:140],hash_result[139:136],hash_result[151:148],hash_result[147:144],hash_result[159:156],hash_result[155:152],hash_result[103:100],hash_result[99:96],hash_result[111:108],hash_result[107:104],hash_result[119:116],hash_result[115:112],hash_result[127:124],hash_result[123:120],hash_result[71:68],hash_result[67:64],hash_result[79:76],hash_result[75:72],hash_result[87:84],hash_result[83:80],hash_result[95:92],hash_result[91:88],hash_result[39:36],hash_result[35:32],hash_result[47:44],hash_result[43:40],hash_result[55:52],hash_result[51:48],hash_result[63:60],hash_result[59:56],hash_result[7:4],hash_result[3:0],hash_result[15:12],hash_result[11:8],hash_result[23:20],hash_result[19:16],hash_result[31:28],hash_result[27:24]};

endmodule
