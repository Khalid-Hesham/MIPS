 module MUX #(parameter MUX_DATA_WIDTH)(
    input   wire    [MUX_DATA_WIDTH-1:0]  in1,
    input   wire    [MUX_DATA_WIDTH-1:0]  in2,
    input   wire                          sel,
    output  reg     [MUX_DATA_WIDTH-1:0]  out
 );
 
always @(*) 
begin
if(sel)
    begin
        out = in2;
    end    
else
    begin
        out = in1;
    end    

end


 endmodule