module ALU(
    input [31:0]data1,
    input [31:0]data2,
    input [3:0]Alu_control,
    output reg zero,       
    output reg [31:0] ALU_result
);
    always @(*) begin
        case (Alu_control)
            4'b0000:ALU_result=  data1 + data2;
            4'b0001:ALU_result= data1 - data2;//branch func and normal subraction
            4'b0010:ALU_result= data1 & data2;
            4'b0011:ALU_result= data1 | data2;
            4'b0100:ALU_result= data1 ^ data2;
            4'b0101:ALU_result= data1 << data2[4:0];//Shift left logical
            4'b0110:ALU_result= data1 >> data2[4:0];//Shift right logical
            4'b0111:ALU_result= $signed(data1) >>> data2[4:0]; //sift right arithematic
            4'b1000:ALU_result= ($signed(data1) < $signed(data2)) ? 32'b1 : 32'b0; //set less than
            4'b1001:ALU_result= (data1 < data2) ? 32'b1 : 32'b0; // SLTU unsigned 
            4'b1010:ALU_result= data2;//pass data2....for LUI
            default:ALU_result=32'b0;
        endcase     
        zero = (ALU_result == 32'b0)? 1:0;
    end
endmodule
