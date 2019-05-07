
`timescale 1ns/1ns

module Mux(in1, in2, sel, out);
  input [7:0] in1, in2;
  input sel;
  output out;
  assign out = sel ? in2 : in1;
endmodule
