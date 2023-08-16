module Sign_Extend(
    input   wire  [15:0]    Sign_Extend_in,
    output  reg   [31:0]    Sign_Extend_out
);

always @(*)
begin
    if(Sign_Extend_in[15] == 1'b0)
    begin
        Sign_Extend_out = {16'h0000 , Sign_Extend_in};
    end
    else if(Sign_Extend_in[15] == 1'b1)
    begin
        Sign_Extend_out = {16'hFFFF , Sign_Extend_in};
    end
end

endmodule