module mux2x1_32bit(
    input [31:0]in1,   
    input [31:0]in0,   
    input sel,          
    output [31:0]out      
);

    assign out= sel? in1:in0;  

endmodule
