module divide(
  rate,
  clk_in,
  clk_out,
  reset
);

input [13:0] rate;
input clk_in,reset;

output clk_out;

reg clk_out;
reg[13:0] state;

always @(posedge clk_in or negedge reset) begin
  if(~reset) begin
    state<=0;
    clk_out<=0;
  end
  else begin
    if(state==14'd0)
      clk_out=~clk_out;
    state<=state+14'd2;
    if(state==rate-2)
      state<=14'd0;
  end
end

endmodule // divide