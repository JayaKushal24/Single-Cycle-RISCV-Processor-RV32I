 module Control(
    input [6:0] opcode,          
    output reg RegWrite,         
    output reg MemRead,          
    output reg MemWrite,         
    output reg MemToReg,        
    output reg ALUSrc,                      
    output reg Branch,                        
    output reg ALUOp0,
    output reg ALUOp1       
);

    always @(*) begin
        case (opcode)
            7'b0110011:  // R-type 
            begin {ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0}={1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b1,1'b0};end
            7'b0010011:   // I-type
            begin {ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0}={1'b1,1'b0,1'b1,1'b0,1'b0,1'b0,1'b1,1'b0};end
            7'b0000011:   // Load 
            begin {ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0}={1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0};end
            7'b0100011:   // Store 
            begin {ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0}={1'b1,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0};end
            7'b1100011:   // Branch 
            begin {ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0}={1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1};end  
            7'b1101111:   // Jump 
            begin {ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0}={1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0};end
            7'b0110111:   // LUI
            begin {ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0}={1'b1,1'b0,1'b1,1'b0,1'b0,1'b0,1'b1,1'b1};end
            default: 
            begin {ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0}={1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};end  
        endcase
    end

endmodule
