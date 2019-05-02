
`timescale 1ns/1ns

module ALU(ALUop, inA, inB, outRes);
  parameter ADD = 0;
  parameter SUB = 1;
  parameter AND = 2;
  parameter NOT = 3;
  // -------------------------------------- //
  input      [1:0] ALUop;
  input      [7:0] inA, inB;
  output reg [7:0] outRes;
  always@(*) begin
    case (ALUop)
      ADD: outRes <= inA + inB;
      SUB: outRes <= inA - inB;
      AND: outRes <= inA && inB;
      NOT: outRes <= !inA;
    endcase
  end
endmodule
