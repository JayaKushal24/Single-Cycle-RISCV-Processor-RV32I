module ALU_Control(
    input [2:0] funct3,
    input [6:0] funct7,
    input ALUOp0,
    input ALUOp1,
    output reg [3:0] ALUcontrol_Out
);

always @(*) begin
  casez ({ALUOp1,ALUOp0, funct7, funct3})
    //R-type Instructions (specific patterns first)
    12'b10_0000000_000: ALUcontrol_Out=4'b0000;//ADD
    12'b10_0100000_000: ALUcontrol_Out=4'b0001;//SUB
    12'b10_0000000_111: ALUcontrol_Out=4'b0010;//AND
    12'b10_0000000_110: ALUcontrol_Out=4'b0011;//OR
    12'b10_0000000_100: ALUcontrol_Out=4'b0100;//XOR
    12'b10_0000000_001: ALUcontrol_Out=4'b0101;//SLL
    12'b10_0000000_101: ALUcontrol_Out=4'b0110;//SRL
    12'b10_0100000_101: ALUcontrol_Out=4'b0111;//SRA
    12'b10_0000000_010: ALUcontrol_Out=4'b1000;//SLT
    12'b10_0000000_011: ALUcontrol_Out=4'b1001;//SLTU

  //I-type Instructions (using ? for don't-care)
    12'b10_???????_000: ALUcontrol_Out=4'b0000;//ADDI
    12'b10_???????_001: ALUcontrol_Out=4'b0101;//SLLI
    12'b10_???????_010: ALUcontrol_Out=4'b1000;//SLTI
    12'b10_???????_011: ALUcontrol_Out=4'b1001;//SLTIU
    12'b10_???????_100: ALUcontrol_Out=4'b0100;//XORI
    12'b10_??1????_101: ALUcontrol_Out=4'b0111;//SRAI
    12'b10_??0????_101: ALUcontrol_Out=4'b0110;//SRLI
    12'b10_???????_110: ALUcontrol_Out=4'b0011;//ORI
    12'b10_???????_111: ALUcontrol_Out=4'b0010;//ANDI

  //Memory operations
    12'b00_???????_???: ALUcontrol_Out=4'b0000;//ADD....load/store
    12'b01_???????_???: ALUcontrol_Out=4'b0001;//SUB....branches

  //LUI
    12'b11_???????_???: ALUcontrol_Out=4'b1010;

    default: ALUcontrol_Out=4'b0000;
  endcase
end

endmodule

