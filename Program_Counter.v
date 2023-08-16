module Program_Counter(
    input wire              PC_CLK,
    input wire              PC_RST,
    input wire  [31:0]      PC_in,
    output reg  [31:0]      PC_out
);

always @(posedge PC_CLK or negedge PC_RST)
begin
  if(!PC_RST)
  PC_out <= 32'b0;
  else 
  PC_out <= PC_in;
end

endmodule