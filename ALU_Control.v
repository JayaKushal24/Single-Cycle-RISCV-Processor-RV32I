
module ALU_Control(        
    input [2:0]funct3,         
    input [6:0]funct7,        
    input ALUOp0,
    input ALUOp1,          
    output reg [3:0] ALUcontrol_Out 
);
always @(*) begin
  casex ({ALUOp1,ALUOp0, funct7, funct3})
 //R type Instructions
    12'b10_0000000_000:ALUcontrol_Out <= 4'b0000;//ADD
    12'b10_0100000_000:ALUcontrol_Out <= 4'b0001;//SUB
    12'b10_0000000_111:ALUcontrol_Out <= 4'b0010;//AND
    12'b10_0000000_110:ALUcontrol_Out <= 4'b0011;//OR
    12'b10_0000000_100:ALUcontrol_Out <= 4'b0100;//XOR
    12'b10_0000000_001:ALUcontrol_Out <= 4'b0101;//Shift Left Logical
    12'b10_0000000_101:ALUcontrol_Out <= 4'b0110;//Shift Right Logical
    12'b10_0100000_101:ALUcontrol_Out <= 4'b0111;//Shift Right Arithmetic
    12'b10_0000000_010:ALUcontrol_Out <= 4'b1000;//Set Less Than signed valure...SLT
    12'b10_0000000_011:ALUcontrol_Out <= 4'b1001;//Set Less Than Unsigned........SLTU
 //I type Instructions
    12'b10_xxxxxxx_000:ALUcontrol_Out <= 4'b0000;//ADDI
    12'b10_xxxxxxx_001:ALUcontrol_Out <= 4'b0101;//SLLI
    12'b10_xxxxxxx_010:ALUcontrol_Out <= 4'b1000;//SLTI
    12'b10_xxxxxxx_011:ALUcontrol_Out <= 4'b1001;//SLTIU
    12'b10_xxxxxxx_100:ALUcontrol_Out <= 4'b0100;//XORI
    12'b10_xx1xxxx_101:ALUcontrol_Out <= 4'b0111;//SRAI
    12'b10_xx0xxxx_101:ALUcontrol_Out <=4'b0110;//SRLI
    12'b10_xxxxxxx_110:ALUcontrol_Out <= 4'b0011; //ORI
    12'b10_xxxxxxx_111:ALUcontrol_Out <= 4'b0010; //ANDI
//Memory
    12'b00_xxxxxxx_xxx:ALUcontrol_Out <= 4'b0000; //ADD for load and store op
    12'b01_xxxxxxx_xxx:ALUcontrol_Out <= 4'b0001; //SUB for branches
//LUI 
    12'b11_xxxxxxx_xxx:ALUcontrol_Out <= 4'b1010;
    
    default            : ALUcontrol_Out <= 4'b0001; 
  endcase
end
endmodule