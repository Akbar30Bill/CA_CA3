
`timescale 1ns/1ns

module DataPath(clk, rst,
                ALUop, PCWrite, PCWriteCond, PCsrc, IorD,
                MemRead, MemWrite, IRWrite, MtoS, ldA, ldB,
                srcA, srcB, push, pop, tos
                );
  input clk, rst;
  input [1:0] ALUop;
  input PCWrite, PCWriteCond, PCsrc, IorD,
        MemRead, MemWrite, IRWrite, MtoS, ldA, ldB,
        srcA, srcB, push, pop, tos;
  reg [4:0] pc;
  reg [7:0] InstructionRegister, MemoryDataRegister, A, B, Zero, outRes;
  wire after_pc_and;
  wire [3:0] Address;
  wire [7:0] WriteData, ReadData, data_in;
  ProgramCounter ProgramCounter(clk, rst, PCin, PCen, PCout);
  Memory memory(clk, rst, Address, WriteData, MemReadEn, MemWriteEn, ReadData);
  Stack stack(data_in, push, pop, tos, clk, rst, data_out);
  ALU alu(ALUop, inA, inB, outRes);
  Mux mux_address_memory(InstructionRegister[4:0], PCout, IorD, Address);
  Mux mux_data_in_stack(outRes, MemoryDataRegister, MtoS, data_in);
  Mux mux_alu_input_1(A, PCout, srcA, inA);
  Mux mux_alu_input_2(B, 8'b00000001, srcB, inB);
  Mux mux_pc(outRes, InstructionRegister[4:0], PCsrc, PCin);
  assign WriteData = A;
  or pc_or(PCen, PCWrite, after_pc_and);
  and pc_and(after_pc_and, Zero, PCWriteCond);
endmodule
