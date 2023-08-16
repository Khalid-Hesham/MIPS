module Control_Unit(
    input   wire    [5:0]   Opcode,
    input   wire    [5:0]   Funct,
    output  reg             MemtoReg,
    output  reg             MemWrite,
    output  reg             Branch,
    output  reg             ALUSrc,
    output  reg             RegDst,
    output  reg             RegWrite,
    output  reg             Jump,
    output  reg     [2:0]   ALUControl 
);
    
// Internal signals declaration
reg [1:0] ALUOp;
    
// ALU Decoder
always @(*) 
begin
    ALUControl = 3'b000;
    casex({ALUOp,Funct})
        8'b00_XXXXXX : ALUControl = 3'b010;
        8'b01_XXXXXX : ALUControl = 3'b100;
        8'b10_10_0000: ALUControl = 3'b010;
        8'b10_10_0010: ALUControl = 3'b100;
        8'b10_10_1010: ALUControl = 3'b110;
        8'b10_01_1100: ALUControl = 3'b101;
        default: ALUControl = 3'b010;
    endcase
end

// Main Decoder
always @(*) 
begin
    MemtoReg = 0;
    MemWrite = 0;
    Branch = 0;
    ALUSrc = 0;
    RegDst = 0;
    RegWrite = 0;
    Jump = 0;
    ALUOp = 'b0;
    case(Opcode)
        6'b10_0011: begin
                    RegWrite = 1;
                    ALUSrc = 1;
                    MemtoReg = 1;
                    end
        
        6'b10_1011: begin
                    MemWrite = 1;
                    ALUSrc = 1;
                    MemtoReg = 1;
                    end
        
        6'b00_0000: begin
                    ALUOp = 'b10;
                    RegWrite = 1;
                    RegDst = 1;
                    end
        
        6'b00_1000: begin
                    RegWrite = 1;
                    ALUSrc = 1;
                    end
        
        6'b00_0100: begin
                    ALUOp = 'b01;
                    Branch = 1;
                    end
        
        6'b00_0010: begin
                    Jump = 1;
                    end
        
        default:    begin
                    MemtoReg = 0;
                    MemWrite = 0;
                    Branch = 0;
                    ALUSrc = 0;
                    RegDst = 0;
                    RegWrite = 0;
                    Jump = 0;
                    ALUOp = 'b0;
                    end
    endcase
end


endmodule