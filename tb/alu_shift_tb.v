`timescale 1ns/1ps
module alu_shift_tb;
    localparam W = 32;
    localparam OP_SLL=4'h5, OP_SRL=4'h6, OP_SRA=4'h7;

    reg[W-1:0] a, b;
    reg[3:0] op;

    wire[W-1:0] y;
    wire carry, overflow, zero, negative;

    alu #(.WIDTH(W)) DUT(.a(a), .b(b), .op(op), .y(y), .carry(carry), .overflow(overflow), .zero(zero), .negative(negative));

    task t(input[3:0] _op, input[W-1:0] _a, input[W-1:0] _b, input[W-1:0] exp_y);
        begin
            op=_op; a=_a; b=_b; #1;
            $display("op=%0h, a=%h, b=%h | y=%h, C=%b, V=%b, Z=%b, N=%b", op, a, b, y, carry, overflow, zero, negative);

            if(y !== exp_y)$fatal(1, "MISMATCH: the expected value is %h", exp_y);
            if(carry !== 1'b0)$fatal(1, "carry should be 0 in shift operations");
            if(overflow !== 1'b0)$fatal(1, "overflow should be 0 in shift operations"); 
        end
    endtask

    initial begin
        $dumpfile("alu_shift_tb.vcd");
        $dumpvars(0, alu_shift_tb);

        t(OP_SLL, 32'h0000_0001, 32'h0000_0004, 32'h0000_0010);
        t(OP_SRL, 32'h0000_0010, 32'h0000_0002, 32'h0000_0004);
        t(OP_SRA, 32'hFFFF_FFE0, 32'h0000_0003, 32'hFFFF_FFFC);

        $display("SLL/SRL/SRA test finished");
        #1 $finish;
    end

endmodule