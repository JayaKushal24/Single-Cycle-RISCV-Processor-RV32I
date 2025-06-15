module Imm_Gen(
input [31:0] Imm_Gen_In,
output reg [31:0] Imm_gen_Out
    );
    always @(*)begin 
     case(Imm_Gen_In[6:0])
        7'b0010011:Imm_gen_Out= {{20{Imm_Gen_In[31]}},  Imm_Gen_In[31:20]}; //I type
        7'b0000011:Imm_gen_Out= {{20{Imm_Gen_In[31]}},  Imm_Gen_In[31:20]}; //Load type..........LB,LW,LH
        7'b0100011:Imm_gen_Out={{20{Imm_Gen_In[31]}},   Imm_Gen_In[31:25],Imm_Gen_In[11:7]};//Store type....SB,SW,SH
        7'b0110111: Imm_gen_Out= {Imm_Gen_In[31:12],    12'b0};               //LUI (Load Upper Immediate)....U type
	    7'b0010111:Imm_gen_Out= {Imm_Gen_In[31:12],    12'b0};               //AUIPC (Add Upper Immediate to PC).......U type
	    7'b1100011:Imm_gen_Out= {{20{Imm_Gen_In[31]}}, Imm_Gen_In[7], Imm_Gen_In[30:25], Imm_Gen_In[11:8], 1'b0};//B type...BE1,BNE,BLT,BGE,BLTU,BGEU 
	    7'b1101111:Imm_gen_Out= {{12{Imm_Gen_In[31]}},Imm_Gen_In[19:12],Imm_Gen_In[20],Imm_Gen_In[30:21], 1'b0};//J type
	         
         default:Imm_gen_Out= 32'b0;
     endcase
     
    end
endmodule
