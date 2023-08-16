module Instruction_Memory(
    input wire  [31:0] Instruction_Memory_in,
    output reg  [31:0] Instruction_Memory_out
);





// 2D Array
    reg [31:0] Instruction_Memory [0:99]; // 32-bit wide vector array with depth=100

// Reading the input machine instructions fInstruction_Memory text file
initial begin
        $readmemh("Factorial_Number.txt",Instruction_Memory);
    end


always @(*)
begin
    Instruction_Memory_out = Instruction_Memory [Instruction_Memory_in >> 2];
end



endmodule