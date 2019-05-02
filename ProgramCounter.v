
`timescale 1ns/1ns

module ProgramCounter(clk, rst, PCin, PCen, PCout);
  input PCen, rst, clk;
  input [2:0] PCin;
  output PCout;
  reg [2:0] PC;
  always@(posedge clk, posedge rst) begin
    if(rst) begin
      PC <= 3'b0;
    end
    else begin
      if (PCen) begin
        PC <= PCin;
      end
    end
  end
  assign PCout = PC;
endmodule
