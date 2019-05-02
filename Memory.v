
`timescale 1ns/1ns

module Memory(clk, rst, Address, WriteData, MemReadEn, MemWriteEn, ReadData);
  input            clk, rst, MemReadEn, MemWriteEn;
  input      [7:0] Address, WriteData;
  output reg [7:0] ReadData;
  reg        [4:0] data [7:0];
  integer i;
  always@(posedge clk, posedge rst) begin
    if(rst) begin
      for(i = 0; i < 32; i = i + 1) begin
        data[i] <= 8'b0;
      end
    end
    else if(MemReadEn)  begin
      ReadData <= data[Address];
    end
    else if(MemWriteEn) begin
      data[Address] <= WriteData;
    end
  end
endmodule
