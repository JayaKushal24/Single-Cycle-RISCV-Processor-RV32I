module top(
    input clk, 
    input rst
);
    wire [31:0]pc,next_pc,pc_plus4,read_data1,read_data2,write_data,imm_value,instruction,alu_srcB,alu_result,mem_read_data,branch_target;
    wire RegWrite,MemRead,MemWrite,MemToReg,ALUSrc,Branch,ALUOp0,ALUOp1,zero;
    wire [4:0]rs1=instruction[19:15];
    wire [4:0]rs2=instruction[24:20];
    wire [4:0]rd=instruction[11:7];
    wire [3:0]alu_control;
   

    program_counter module1(
        .clk(clk),
        .reset(rst),
        .next_pc(next_pc),
        .pc(pc)
    );

    PC_Adder module2(
        .pc_in(pc),
        .pc_out(pc_plus4)
    );

    instruction_memory module3(
        .read_address({pc[31:2],2'b00}),
        .instruction(instruction)
    );

    Control module4(
        .opcode(instruction[6:0]),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .ALUSrc(ALUSrc),
        .Branch(Branch),
        .ALUOp0(ALUOp0),
        .ALUOp1(ALUOp1)
    );

    registers module5(
        .clk(clk),
        .rst(rst),
        .write_data(write_data),
        .write_register(rd),
        .read_register1(rs1),
        .read_register2(rs2),
        .reg_write(RegWrite),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    Imm_Gen module6(
        .Imm_Gen_In(instruction),
        .Imm_gen_Out(imm_value)
    );

    mux2x1_32bit module7(
        .in1(imm_value),
        .in0(read_data2),
        .sel(ALUSrc),
        .out(alu_srcB)
    );

    Branch_Adder module8(
        .PC(pc),
        .offset(imm_value),
        .destination(branch_target)
    );

    ALU module9(
        .data1(read_data1),
        .data2(alu_srcB),
        .Alu_control(alu_control),
        .zero(zero),
        .ALU_result(alu_result)
    );


    ALU_Control module10(
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .ALUOp0(ALUOp0),
        .ALUOp1(ALUOp1),
        .ALUcontrol_Out(alu_control)
    );
    
    mux2x1_32bit module11(//PC source mux..branch or sequential
        .in1(branch_target),
        .in0(pc_plus4),
        .sel(Branch & zero),
        .out(next_pc)
    );
    
    data_memory module12(
        .clk(clk),
        .rst(rst),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(alu_result),
        .write_data(read_data2),
        .read_data(mem_read_data)
    );

    
    //Result source mux....ALU or memory
    mux2x1_32bit module13(
        .in1(mem_read_data),
        .in0(alu_result),
        .sel(MemToReg),
        .out(write_data)
    );


endmodule
