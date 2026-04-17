`timescale 1ns / 1ps

module ALU #(parameter DW = 4)
    (clk, rst_n, A, B, C, sel);
input clk, rst_n;
input [2:0]sel;
input [DW-1:0]B, C;
reg [DW-1:0]B_buf, C_buf;
reg [DW-1:0]calculation;
reg [1:0]flag_cmp; // flag = cmp(B, C), flag = 0(B=C), 1(B>C), 2(B<C)
output reg [DW-1:0]A;

// Instruction Set
// S2 S1 S0, Instruction
//  0  0  0, MOV A, 0
//  0  0  1, MOV calculation, B 
//  0  1  0, MOV calculation, C
//  0  1  1, MUL B, C
//  1  0  0, CMP B, C => FLAG_CMP
//  1  0  1, 
//  1  1  0, 
//  1  1  1, NOP
always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        A <= 0;
        B_buf <= 0;
        C_buf <= 0;
        
    end
    else begin
        // Pipeline - level 1
        B_buf <= B;
        C_buf <= C;

        // Pipeline - level 2
        case(sel)
            3'b001: calculation <= B_buf;
            3'b010: calculation <= C_buf;
            3'b011: calculation <= B_buf * C_buf;
            3'b100: begin
                if(B_buf == C_buf) flag_cmp <= 0;
                else if(B_buf > C_buf) flag_cmp <= 1;
                else flag_cmp <= 2;
            end
        endcase

        // Pipeline - level 3
        if(sel==3'b000) A <= 0;
        if(calculation!=0) A <= A + calculation;
    end
end
endmodule