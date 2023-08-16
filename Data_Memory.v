module Data_Memory (
    input   wire            Data_Memory_CLK,
    input   wire            Data_Memory_RST,
    input   wire            WE,
    input   wire    [31:0]  WD,
    input   wire    [31:0]  A,
    output  reg     [31:0]  RD,
    output  wire    [15:0]  test_value
);

//loop counter
integer i;


// 2D Array
    reg [31:0] Data_Memory [0:99]; // 32-bit wide vector array with depth=100

// test_value
assign test_value = Data_Memory[0];

// Read Operation
always @(*)
begin
  RD = Data_Memory [A];
end

// Write operation
always @(posedge Data_Memory_CLK or negedge Data_Memory_RST) 
begin
    if(!Data_Memory_RST)
        for (i = 0; i < 100 ; i = i + 1)
            Data_Memory[i] <= 'b0;
    else if(WE)
        Data_Memory[A] <= WD;        
end



endmodule