`timescale 1ns/1ps
module alu_logic_tb;
    localparam W = 32;
    localparam OP_AND = 4'h2, OP_OR = 4'h3, OP_XOR = 4'h4;

    reg[W-1:0] a, b;
    reg[3:0] op;

    wire[W-1:0] y;
    wire carry, overflow, zero, negative;

    alu #(.WIDTH(W)) DTU(.a(a), .b(b), .op(op), .y(y), .carry(carry), .overflow(overflow), .zero(zero), .negative(negative));

    task t(input[3:0] _op, input[W-1:0] _a, input[W-1:0] _b, input[W-1:0] exp_y);
        begin
            op = _op; a = _a; b = _b; #1;
            $display("op=%0h, a=%h, b=%h | y=%h, C=%b, V=%b, Z=%b, N=%b", op, a, b, y, carry, overflow, zero, negative);

            if(y != exp_y) $fatal(1, "MISMATCH: expected %h", exp_y);
            if(carry !== 1'b0) $fatal(1, "carry should be 0 for logic operations");
            if(overflow !== 1'b0)$fatal(1, "overflow should be 0 for logic operations");
        end
    endtask

    initial begin
        $dumpfile("logic_waves.vcd");
        $dumpvars(0, alu_logic_tb);

        t(OP_AND, 32'hF0F0_0000, 32'h0FF0_F0FF, 32'h00F0_0000);
        t(OP_OR, 32'h00F0_00F0, 32'h0F0F_0000, 32'h0FFF_00F0);
        t(OP_XOR, 32'hFFFF_0000, 32'h00FF_FFFF, 32'hFF00_FFFF);

        //zero/negative sanity
        t(OP_AND, 32'h0000_0000, 32'hFFFF_FFFF, 32'h0000_0000);
        t(OP_OR, 32'h8000_0000, 32'h0000_0000, 32'h8000_0000);

        $display("AND/OR/XOR tests passed.");
        #1 $finish;
    end

endmodule