module Branch_Adder(
    input [31:0]PC,                    
    input [31:0]offset,                 
    output reg [31:0]destination     
);

    always @(*) begin
        destination = PC +4+ offset;  
    end

endmodule
