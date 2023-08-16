module ALU(
    input wire [2:0]    ALU_FUN,
    input wire [31:0]   ALU_IN1,
    input wire [31:0]   ALU_IN2,
    output reg          Zero_flag,
    output reg [31:0]   ALU_OUT
);

// reg [31:0]  ALU_OUT_Comb;

always @(*)
begin
  ALU_OUT = 32'b0;
  case (ALU_FUN)
    3'b000    :   ALU_OUT = ALU_IN1 & ALU_IN2;
    3'b001    :   ALU_OUT = ALU_IN1 | ALU_IN2;
    3'b010    :   ALU_OUT = ALU_IN1 + ALU_IN2;
//  3'b011    :   Not used
    3'b100    :   ALU_OUT = ALU_IN1 - ALU_IN2;
    3'b101    :   ALU_OUT = ALU_IN1 * ALU_IN2;
    3'b110    :   ALU_OUT = ALU_IN1 < ALU_IN2? 32'b1 : 32'b0;
//  3'b111    :   Not used
    default   :   ALU_OUT = 32'b0; 
  endcase
end

always @(*)
begin
  Zero_flag = (ALU_OUT == 32'b0)? 1'b1 : 1'b0;
end


endmodule