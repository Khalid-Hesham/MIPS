`timescale 1ns / 1ps


module MIPS_TB();
reg             CLK_TB;
reg             RST_TB;
wire    [15:0]  test_value_TB;


parameter clk_period = 10;


initial 
begin
    CLK_TB = 0;
    RST_TB = 1;
    #10;
    RST_TB = 0;
    #10;
    RST_TB = 1;
    #400;
    RST_TB = 0;
    #10;
    
    $stop;
end



always #(clk_period/2) CLK_TB = ~CLK_TB;


MIPS_TOP DUT(
    .CLK(CLK_TB),
    .RST(RST_TB),
    .test_value(test_value_TB)
);


endmodule