module Shift_Left_Twice #(parameter SLT_Data_width)(
    input   wire    [SLT_Data_width-1:0]    SLT_in,
    output  reg     [SLT_Data_width-1:0]    SLT_out
);

always @(*) 
begin
    SLT_out = SLT_in << 2;    
end

endmodule