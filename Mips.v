
`timescale 1ns / 1ns

module Mips(clk, rst);
  input clk, rst;
  wire PCWrite, PCWriteCond, PCsrc, instruction,
       IorD, MemRead, MemWrite, IRWrite, MtoS, ldA, ldB, srcA, srcB,
       ALUop, push, pop, tos;
  wire [5:0] PC;
  DataPath dataPath( clk, rst,
                     ALUop, PCWrite, PCWriteCond, PCsrc, IorD,
                     MemRead, MemWrite, IRWrite, MtoS, ldA, ldB,
                     srcA, srcB, push, pop, tos
                     );
  Controller controller( clk, rst, PCWrite, PCWriteCond, PCsrc, instruction,
                         IorD, MemRead, MemWrite, IRWrite, MtoS, ldA, ldB, srcA, srcB,
                         ALUop, push, pop, tos, PC
                         );
endmodule
