module Data_Path(
    input   wire            Data_Path_CLK,
    input   wire            Data_Path_RST,
    input   wire            MemWrite,
    input   wire            RegWrite,
    input   wire            RegDst,
    input   wire            ALUSrc,
    input   wire            MemtoReg,
    input   wire            Branch,
    input   wire            Jump,
    input   wire    [2:0]   ALUControl,
    output  wire    [5:0]   Opcode,
    output  wire    [5:0]   Funct,
    output  wire    [15:0]  test_value
    );
    
// Internal Signals declaration
    wire Zero_flag;
    wire [27:0] SLT1_out;                        
    wire [31:0] SLT2_out; 
    wire [31:0] SignImm;                            // Sign extend output 
    wire [31:0] ReadData;                           // Data memory output 
    wire [31:0] Instr;                              // instruction memory output 
    wire [31:0] PCPlus4, PCBranch, Branch_mux_out;  // inputs and output for branch mux
    wire [31:0] ALU_mux_out;                        // output for ALU mux
    wire [31:0] Result;                             // output for Data_Memory mux
    wire [31:0] ALUResult;                          // ALU output 
    wire [31:0] PC_in_sig;                          // input and output for PC
    wire [31:0] PC;                                 // input and output for PC
    wire [4:0]  WriteReg;                           // address of the write reg      
    wire [31:0] RD1_sig, RD2_sig;                   // output of Reg_File

// Assign statements
    assign Opcode = Instr[31:26];
    assign Funct = Instr[5:0];


// Modules Instantiation

    MUX #(.MUX_DATA_WIDTH('d32)) Branch_mux(
        .in1(PCPlus4),
        .in2(PCBranch),
        .sel(Branch & Zero_flag),
        .out(Branch_mux_out)
    );
    
    MUX #(.MUX_DATA_WIDTH('d32)) Jump_mux(
        .in1(Branch_mux_out),
        .in2({PCBranch[31:28],SLT1_out[27:0]}),
        .sel(Jump),
        .out(PC_in_sig)
    );
    
    Program_Counter PC_U0(
        .PC_CLK(Data_Path_CLK),
        .PC_RST(Data_Path_RST),
        .PC_in(PC_in_sig),
        .PC_out(PC)
    );
    
    Instruction_Memory ROM(
        .Instruction_Memory_in(PC),
        .Instruction_Memory_out(Instr)
    );
    
    Adder Add1(
        .A(PC),
        .B('d4),
        .C(PCPlus4)
    );
    
    Reg_File Reg_F(
        .Reg_File_CLK(Data_Path_CLK),
        .Reg_File_RST(Data_Path_RST),
        .A1(Instr[25:21]),
        .A2(Instr[20:16]),
        .A3(WriteReg),
        .WD3(Result),
        .WE3(RegWrite),
        .RD1(RD1_sig),
        .RD2(RD2_sig)
    );
    
    Sign_Extend SE(
        .Sign_Extend_in(Instr[15:0]),
        .Sign_Extend_out(SignImm)
    );

    Shift_Left_Twice #(.SLT_Data_width('d28)) SLT1(
        .SLT_in({2'b00,Instr[25:0]}),
        .SLT_out(SLT1_out)
    );

    MUX #(.MUX_DATA_WIDTH('d5)) Write_Reg_mux(
        .in1(Instr[20:16]),
        .in2(Instr[15:11]),
        .sel(RegDst),
        .out(WriteReg)
    );
    
    MUX #(.MUX_DATA_WIDTH('d32)) ALU_mux(
        .in1(RD2_sig),
        .in2(SignImm),
        .sel(ALUSrc),
        .out(ALU_mux_out)
    );
    
    ALU ALU_U(
        .ALU_IN1(RD1_sig),
        .ALU_IN2(ALU_mux_out),
        .ALU_FUN(ALUControl),
        .ALU_OUT(ALUResult),
        .Zero_flag(Zero_flag)
    );
    
    Data_Memory RAM(
        .Data_Memory_CLK(Data_Path_CLK),
        .Data_Memory_RST(Data_Path_RST),
        .WE(MemWrite),
        .WD(RD2_sig),
        .A(ALUResult),
        .RD(ReadData),
        .test_value(test_value)
    );
    
    Shift_Left_Twice #(.SLT_Data_width('d32)) SLT2(
        .SLT_in(SignImm),
        .SLT_out(SLT2_out)
    );
    
    Adder Add2(
        .A(SLT2_out),
        .B(PCPlus4),
        .C(PCBranch)
    );

    MUX #(.MUX_DATA_WIDTH('d32)) Data_Memory_mux(
        .in1(ALUResult),
        .in2(ReadData),
        .sel(MemtoReg),
        .out(Result)
    );
    


    
endmodule