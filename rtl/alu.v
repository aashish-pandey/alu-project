// alu.v - Parametric , synthesizable ALU 
`timescale 1ns/1ps

module alu #(
    parameter WIDTH = 32
)(
    input wire [WIDTH-1:0] a,
    input wire [WIDTH-1:0] b,
    input wire [3:0] op, 
    output reg [WIDTH-1:0] y, 
    output reg              carry,
    output reg             overflow,
    output wire              zero,
    output wire              negative
);

    //TODO next: implement ops inside an always @* with a case(op)

    assign zero = (y == {WIDTH{1'b0}}); //this is the replicator operator in verilog. it just means that there are 0's of width length. or 0 is copied for width times.
    assign negative = y[WIDTH-1];

endmodule