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

    //opcodes (Keeping them stable: extending them later)
    localparam OP_ADD = 4'h0;
    localparam OP_SUB = 4'h1;

    // precompute add/sub results and overflow bits
    wire [WIDTH:0] add_full = {1'b0, a} + {1'b0, b}; //WIDTH+1 to capture the carry-out
    wire [WIDTH:0] sub_full = {1'b0, a} + {1'b0, (~b + {{(WIDTH-1){1'b0}}, 1'b1})}; //2's comp;ement. = 1's complement + 1; 1's complement = fliping of numbers

    wire add_ovf = (a[WIDTH-1] == b[WIDTH-1]) && (a[WIDTH-1] != add_full[WIDTH-1]);
    wire sub_ovf = (a[WIDTH-1] != b[WIDTH-1]) && (a[WIDTH-1] != sub_full[WIDTH-1]);

    always @ * 
    begin
        //safe defaults
        y = {WIDTH{1'b0}};
        carry = 1'b0;
        overflow = 1'b0;


        case (op)
            OP_ADD: 
                begin
                    y = add_full[WIDTH-1:0];
                    carry = add_full[WIDTH];
                    overflow = add_ovf;
                end
            OP_SUB:
                begin
                    y = sub_full[WIDTH-1:0];
                    carry=sub_full[WIDTH];
                    overflow = sub_ovf;
                end
            default: 
                begin
                    y = {WIDTH{1'b0}};
                    carry = 1'b0;
                    overflow = 1'b0;
                end
        endcase
    end
    


    assign zero = (y == {WIDTH{1'b0}}); //this is the replicator operator in verilog. it just means that there are 0's of width length. or 0 is copied for width times.
    assign negative = y[WIDTH-1];

endmodule