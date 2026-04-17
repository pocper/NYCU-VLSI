`timescale 1ns/1ps

`include "dequan.sv"
`include "PCT.sv"
`include "postfilter.sv"
`include "YUV_RGB.sv"
`include "PATTERN.sv"

module TESTBENCH();

logic signed [7:0] inv[15:0];
logic signed [15:0] m1v[15:0];
logic signed [15:0] m2v[15:0];
logic signed [15:0] m3v[15:0];
logic signed [7:0] inu[15:0];
logic signed [15:0] m1u[15:0];
logic signed [15:0] m2u[15:0];
logic signed [15:0] m3u[15:0];
logic signed [7:0] iny[15:0];
logic signed [15:0] m1y[15:0];
logic signed [15:0] m2y[15:0];
logic signed [15:0] m3y[15:0];

logic signed [15:0] outr[15:0];
logic signed [15:0] outg[15:0];
logic signed [15:0] outb[15:0];
// logic inv[15:0], inu[15:0], iny[15:0];
// logic m1v[15:0], m1u[15:0], m1y[15:0];
// logic m2v[15:0], m2u[15:0], m2y[15:0];
// logic m3v[15:0], m3u[15:0], m3y[15:0];
logic clk, rst_n;

initial begin
    $dumpfile("jpeg_decoder_sim.vcd");
    $dumpvars(0);
    $dumpall;
end

dequan I_dequanv
(
  clk,
  inv[0],   inv[1],   inv[2],   inv[3],
  inv[4],   inv[5],   inv[6],   inv[7],
  inv[8],   inv[9],   inv[10],  inv[11],
  inv[12],  inv[13],  inv[14],  inv[15],
  m1v[0],   m1v[1],   m1v[2],   m1v[3],
  m1v[4],   m1v[5],   m1v[6],   m1v[7],
  m1v[8],   m1v[9],   m1v[10],  m1v[11],
  m1v[12],  m1v[13],  m1v[14],  m1v[15]
);

dequan I_dequanu
(
  clk,
  inu[0],   inu[1],   inu[2],   inu[3],
  inu[4],   inu[5],   inu[6],   inu[7],
  inu[8],   inu[9],   inu[10],  inu[11],
  inu[12],  inu[13],  inu[14],  inu[15],
  m1u[0],   m1u[1],   m1u[2],   m1u[3],
  m1u[4],   m1u[5],   m1u[6],   m1u[7],
  m1u[8],   m1u[9],   m1u[10],  m1u[11],
  m1u[12],  m1u[13],  m1u[14],  m1u[15]
);

dequan I_dequany
(
  clk,
  iny[0],   iny[1],   iny[2],   iny[3],
  iny[4],   iny[5],   iny[6],   iny[7],
  iny[8],   iny[9],   iny[10],  iny[11],
  iny[12],  iny[13],  iny[14],  iny[15],
  m1y[0],   m1y[1],   m1y[2],   m1y[3],
  m1y[4],   m1y[5],   m1y[6],   m1y[7],
  m1y[8],   m1y[9],   m1y[10],  m1y[11],
  m1y[12],  m1y[13],  m1y[14],  m1y[15]
);

PCT I_PCTv
(
  clk,
  m1v[0],   m1v[1],   m1v[2],   m1v[3],
  m1v[4],   m1v[5],   m1v[6],   m1v[7],
  m1v[8],   m1v[9],   m1v[10],  m1v[11],
  m1v[12],  m1v[13],  m1v[14],  m1v[15],
  m2v[0],   m2v[1],   m2v[2],   m2v[3],
  m2v[4],   m2v[5],   m2v[6],   m2v[7],
  m2v[8],   m2v[9],   m2v[10],  m2v[11],
  m2v[12],  m2v[13],  m2v[14],  m2v[15]
);

PCT I_PCTu
(
  clk,
  m1u[0],   m1u[1],   m1u[2],   m1u[3],
  m1u[4],   m1u[5],   m1u[6],   m1u[7],
  m1u[8],   m1u[9],   m1u[10],  m1u[11],
  m1u[12],  m1u[13],  m1u[14],  m1u[15],
  m2u[0],   m2u[1],   m2u[2],   m2u[3],
  m2u[4],   m2u[5],   m2u[6],   m2u[7],
  m2u[8],   m2u[9],   m2u[10],  m2u[11],
  m2u[12],  m2u[13],  m2u[14],  m2u[15]
);

PCT I_PCTy
(
  clk,
  m1y[0],   m1y[1],   m1y[2],   m1y[3],
  m1y[4],   m1y[5],   m1y[6],   m1y[7],
  m1y[8],   m1y[9],   m1y[10],  m1y[11],
  m1y[12],  m1y[13],  m1y[14],  m1y[15],
  m2y[0],   m2y[1],   m2y[2],   m2y[3],
  m2y[4],   m2y[5],   m2y[6],   m2y[7],
  m2y[8],   m2y[9],   m2y[10],  m2y[11],
  m2y[12],  m2y[13],  m2y[14],  m2y[15]
);


postfilter I_postfilterv
(
  clk,
  m2v[0],   m2v[1],   m2v[2],   m2v[3],
  m2v[4],   m2v[5],   m2v[6],   m2v[7],
  m2v[8],   m2v[9],   m2v[10],  m2v[11],
  m2v[12],  m2v[13],  m2v[14],  m2v[15],
  m3v[0],   m3v[1],   m3v[2],   m3v[3],
  m3v[4],   m3v[5],   m3v[6],   m3v[7],
  m3v[8],   m3v[9],   m3v[10],  m3v[11],
  m3v[12],  m3v[13],  m3v[14],  m3v[15]
);

postfilter I_postfilteru
(
  clk,
  m2u[0],   m2u[1],   m2u[2],   m2u[3],
  m2u[4],   m2u[5],   m2u[6],   m2u[7],
  m2u[8],   m2u[9],   m2u[10],  m2u[11],
  m2u[12],  m2u[13],  m2u[14],  m2u[15],
  m3u[0],   m3u[1],   m3u[2],   m3u[3],
  m3u[4],   m3u[5],   m3u[6],   m3u[7],
  m3u[8],   m3u[9],   m3u[10],  m3u[11],
  m3u[12],  m3u[13],  m3u[14],  m3u[15]
);

postfilter I_postfiltery
(
  clk,
  m2y[0],   m2y[1],   m2y[2],   m2y[3],
  m2y[4],   m2y[5],   m2y[6],   m2y[7],
  m2y[8],   m2y[9],   m2y[10],  m2y[11],
  m2y[12],  m2y[13],  m2y[14],  m2y[15],
  m3y[0],   m3y[1],   m3y[2],   m3y[3],
  m3y[4],   m3y[5],   m3y[6],   m3y[7],
  m3y[8],   m3y[9],   m3y[10],  m3y[11],
  m3y[12],  m3y[13],  m3y[14],  m3y[15]
);


YUV_RGB I_YUV_RGB
(
  clk,
  m3y[0],   m3y[1],   m3y[2],   m3y[3],
  m3y[4],   m3y[5],   m3y[6],   m3y[7],
  m3y[8],   m3y[9],   m3y[10],  m3y[11],
  m3y[12],  m3y[13],  m3y[14],  m3y[15], 

  m3u[0],   m3u[1],   m3u[2],   m3u[3],
  m3u[4],   m3u[5],   m3u[6],   m3u[7],
  m3u[8],   m3u[9],   m3u[10],  m3u[11],
  m3u[12],  m3u[13],  m3u[14],  m3u[15],

  m3v[0],   m3v[1],   m3v[2],   m3v[3],
  m3v[4],   m3v[5],   m3v[6],   m3v[7],
  m3v[8],   m3v[9],   m3v[10],  m3v[11],
  m3v[12],  m3v[13],  m3v[14],  m3v[15],

  outr[0],   outr[1],   outr[2],   outr[3],
  outr[4],   outr[5],   outr[6],   outr[7],
  outr[8],   outr[9],   outr[10],  outr[11],
  outr[12],  outr[13],  outr[14],  outr[15],

  outg[0],   outg[1],   outg[2],   outg[3],
  outg[4],   outg[5],   outg[6],   outg[7],
  outg[8],   outg[9],   outg[10],  outg[11],
  outg[12],  outg[13],  outg[14],  outg[15],

  outb[0],   outb[1],   outb[2],   outb[3],
  outb[4],   outb[5],   outb[6],   outb[7],
  outb[8],   outb[9],   outb[10],  outb[11],
  outb[12],  outb[13],  outb[14],  outb[15]
);

PATTERN I_PATTERN
(
  .clk(clk),
  .inv(inv),
  .inu(inu),
  .iny(iny)
);
endmodule