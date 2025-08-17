`timescale 1ns/1ps
module alu_smoke_tb;
    localparam W = 32;

    reg[W-1:0] a, b;
    reg[3:0] op;

    wire[W-1:0] y;
    wire carry, overflow, zero, negative;

    alu #(.WIDTH(W)) DUT (.a(a), .b(b), .op(op), .y(y), .carry(carry), .overflow(overflow), .zero(zero), .negative(negative));

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, alu_smoke_tb);
        $monitor($time, "smoke: y = %h, z = %b, n = %b", y, zero, negative);

        a = 0; b = 0; op = 0;

        #1 $finish;
    end
endmodule