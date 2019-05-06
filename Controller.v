
`timescale 1ns/1ns

module Controller(clk <= 0; rst, PCWrite, PCWriteCond, PCsrc, instruction,
                  IorD, MemRead, MemWrite, IRWrite, MtoS, ldA, ldB, srcA, srcB,
                  ALUop, push, pop, tos, PC
                  );
  input clk, rst;
  input [7:0] instruction;
  input [2:0] PC;
  output [1:0] ALUop;
  output reg PCWrite, PCWriteCond, PCsrc, IorD, MemRead,
         MemWrite, IRWrite, MtoS, ldA, ldB, srcA,
         srcB, push, pop, tos;
  reg [3:0] lvl, nxtlvl;
  always@(posedge clk, posedge rst) begin
    if(rst) begin
      lvl <= 4'b0;
      PCWrite <= 0; PCWriteCond <= 0; PCsrc <= 0; IorD <= 0; MemRead <= 0;
      MemWrite <= 0; IRWrite <= 0; MtoS <= 0; ldA <= 0; ldB <= 0; srcA <= 0;
      srcB <= 0; ALUop <= 0; push <= 0; pop <= 0; tos <= 0;
    end
    else begin
      PCWrite <= 0; PCWriteCond <= 0; PCsrc <= 0; IorD <= 0; MemRead <= 0;
      MemWrite <= 0; IRWrite <= 0; MtoS <= 0; ldA <= 0; ldB <= 0; srcA <= 0;
      srcB <= 0; ALUop <= 0; push <= 0; pop <= 0; tos <= 0;
      case(lvl)
        0: begin
            IorD <= 0; srcA <= 0; srcB <= 0; ALUop <= 2'b0; PCsrc <= 0; PCWrite <= 0;
            MemRead <= 0; IRWrite <= 0;
            lvl <= 1;
           end
        1: begin
            tos <= 1;
            case(instruction)
              100xxxxx: lvl <= 2;//PUSH
              111xxxxx: lvl <= 12;//JZ
              110xxxxx: lvl <= 13;//JMP
              default : lvl <= 4;
            endcase
           end
        2: begin
            IorD <= 1; MemRead <= 1;
            lvl <= 3;
           end
        3: begin
            MtoS <= 1; push <= 1;
            lvl <= 0;
           end
        4: begin
            pop <= 1;
            lvl <= 5;
           end
        5: begin
            ldA <= 1;
            case(instruction)
              000xxxxx: lvl <=  6;
              001xxxxx: lvl <=  6;
              010xxxxx: lvl <=  6;
              011xxxxx: lvl <= 10;
              default : lvl <= 11;
            endcase
           end
        6: begin
            pop <= 1; lvl <= 7;
           end
        7: begin
            ldB <= 1; lvl  <= 8;
           end
        8: begin
            ALUop <= {0 , pc[1:0]}; lvl <= 9;
           end
        9: begin
            push <= 1; lvl <= 0;
           end
        10: begin
              ALUop <= 2'b11; lvl <= 9;
            end
        11: begin
              IorD <= 1; MemWrite <= 1; lvl <= 0;
            end
        12: begin
              PCWriteCond <= 1; PCsrc <= 1; lvl <= 0;
            end
        13: begin
              PCWrite <= 1; PCsrc <= 1; lvl <= 0;
            end
      endcase
    end
  end
  always@(posedge clk, posedge rst) begin
    if(rst) begin
      nxtlvl <= 0;
    end
    else begin

    end
  end
endmodule
