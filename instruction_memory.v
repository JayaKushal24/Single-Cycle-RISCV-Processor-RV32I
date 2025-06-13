
module instruction_memory(
    input [31:0]read_address,
    output [31:0]instruction
);
    reg [31:0]mem[63:0];
    integer i;
    initial begin
        for (i= 0; i<64; i=i+1)
            mem[i] = 32'h00000000;

        //sample RISC-V instructions
        mem[0]=32'h00500413;//addi x8,x0,5...........................x8=5
        mem[1]=32'h00300493;//addi x9,x0,3..........................x9=3
        mem[2]=32'h00944533;//add  x10,x8,x9.........................x10=8
        mem[3]=32'h41448433;//addi x8,x9,-8......................x8= -5
        mem[4]=32'h00A2A023;//sw   x10,0(x5).....................store x10 at address 0
        mem[5]=32'h0002A303;//lw   x6,0(x5).......................x6=8
        mem[6]=32'h00640463;//beq  x8,x6,+8.....................branch not taken......x8=-5 x6=8
        mem[7]=32'h00100313;//addi x6,x0,1.....................x6=1
        mem[8]=32'h00200313;//addi x6,x0,2....................x6=2
        mem[9]=32'h00648463;//beq  x9,x6,+8...................branch not taken.....x9=3 x6=2
        mem[10]=32'h00200493;//addi x9,x0,2..................x9 = 2
        mem[11]=32'h00200313;//addi x6,x0,2..................x6 = 2
        mem[12]=32'h00648463;//beq  x9,x6,+8................branch taken .........x9=2 == x6=2)
        mem[13]=32'h00000000;//....................nop 
        mem[14]=32'h00000000;//....................nop
        mem[15]=32'hFFFFF113;//addi x2,x0,-1.....................x2 = -1...Branch target

    end
        
    
       assign  instruction=mem[read_address>>2];
    endmodule