module divide(
  rate,
  clk_in,
  clk_out,
  reset
);

input [13:0] rate;
input clk_in,reset;

output clk_out;

reg[13:0] state;

always @(posedge clk_in or negedge reset) begin
  if(~reset) begin
    state<=0;
    clk_out<=0;
  end
  else begin
    if(state==0) clk_out=~clk_out;
    else if(state==rate-13'd2) state<=0;
    else begin
      state<=state+13'd2;
    end
  end
end

endmodule // divide