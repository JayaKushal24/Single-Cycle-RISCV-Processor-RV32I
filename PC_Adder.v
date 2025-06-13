//Same as MIPS32
module PC_Adder(
input [31:0]pc_in,
output [31:0]pc_out
    );
    assign pc_out =  pc_in+4;
endmodule