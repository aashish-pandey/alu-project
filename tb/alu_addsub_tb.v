`timescale 1ns/1ps
module alu_addsub_tb;
    localparam W = 32;
    localparam OP_ADD = 4'h0, OP_SUB = 4'h1;

    reg[W-1:0] a, b;
    reg[3:0] op;

    wire[W-1:0] y;
    wire carry, overflow, zero, negative;

    alu #(.WIDTH(W)) DUT (.a(a), .b(b), .op(op), .y(y), .carry(carry), .overflow(overflow), .zero(zero), .negative(negative));

    task do_test(input [3:0] _op, input[W-1:0] _a, input[W-1:0] _b, input[W-1:0] exp_y);
        begin
            op = _op; a = _a; b = _b; #1;
            $display("op=%0h a=%h b=%h | y=%h C=%b V=%b Z=%b N=%b", op, a, b, y, carry, overflow, zero, negative);
            if(y !== exp_y)
                begin
                    $display("** MISMATCH: expected %h", exp_y);
                    $fatal;
                end
        end
    endtask

    initial begin
        $dumpfile("addsub_waves.vcd");
        $dumpvars(0, alu_addsub_tb);

        //ADD basics
        do_test(OP_ADD, 32'h0000_0001, 32'h0000_0001, 32'h0000_0002);
        do_test(OP_ADD, 32'hFFFF_FFFF, 32'h0000_0001, 32'h0000_0000);

        //ADD signed overflow
        op=OP_ADD; a=32'h7FFF_FFFF; b=32'h0000_0001; #1;
        if(!overflow) $fatal(1, "Expected overflow on 0x7fffffff + 1");

        //SUB basics
        do_test(OP_SUB, 32'h0000_0003, 32'h0000_0001, 32'h0000_0002);
        do_test(OP_SUB, 32'h0000_0000, 32'h0000_0001, 32'hFFFF_FFFF);

        //SUB signed overflow
        op=OP_SUB; a=32'h8000_0000; b=32'h0000_0001; #1;
        if(!overflow) $fatal(1, "Expected overflow on 0x80000000 - 1");

        $display("ADD/SUB tests passed");
        #1 $finish;
    end
    
endmodule