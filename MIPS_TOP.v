module MIPS_TOP (
    input   wire            CLK,
    input   wire            RST,
    output  wire    [15:0]  test_value   
);

// Internal signals declarations
    wire MemWrite,RegWrite,RegDst,ALUSrc,MemtoReg,Branch,Jump;
    wire [2:0] ALUControl;
    wire [5:0] Opcode,Funct;
    
//  Modules Instantiations    
    Data_Path DP(
        .Data_Path_CLK(CLK),
        .Data_Path_RST(RST),
        .MemWrite(MemWrite),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .Branch(Branch),
        .Jump(Jump),
        .ALUControl(ALUControl),
        .Opcode(Opcode),
        .Funct(Funct),
        .test_value(test_value)
    );
    
    Control_Unit CU(
        .Opcode(Opcode),
        .Funct(Funct),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .ALUControl(ALUControl)
    );


endmodule