
`timescale 1ns/1ns

module Stack(data_in, push, pop, tos, clk, rst, data_out);
  input              push, pop, tos, clk, rst;
  input       [7:0]  data_in;
  output reg  [7:0]  data_out;
  reg         [31:0] data [7:0];
  reg         [31:0] ptr;
  always@(posedge clk, posedge rst) begin
    if(rst)  begin
      ptr       <= 32'b0;
    end
    else if(pop)  begin
      data_out  <= data[ptr];
      ptr       <= ptr - 1  ;
    end
    else if(push) begin
      ptr       <= ptr + 1;
      data[ptr] <= data_in;
    end
    else if(tos)  begin
      data_out  <= data[ptr];
    end
  end
endmodule
