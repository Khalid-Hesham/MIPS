module Reg_File(
    input wire          Reg_File_CLK,
    input wire          Reg_File_RST,
    input wire [4:0]    A1,
    input wire [4:0]    A2,
    input wire [4:0]    A3,
    input wire          WE3,
    input wire [31:0]   WD3,
    output reg [31:0]   RD1,
    output reg [31:0]   RD2
);

// loop counter
integer i;

// 2D Array
    reg [31:0] Reg_File [0:99]; // 32-bit wide vector array with depth=100

// Read Operation
always @(*)
begin
  RD1 = Reg_File[A1];
  RD2 = Reg_File[A2];
end

// Write operation
always @(posedge Reg_File_CLK or negedge Reg_File_RST) 
begin
    if(!Reg_File_RST)
        for (i = 0; i < 100 ; i = i + 1)
            Reg_File[i] <= 'b0;
    if(WE3)
        Reg_File[A3] <= WD3;        
end

endmodule