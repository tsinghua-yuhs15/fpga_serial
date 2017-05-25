module transmitter(
  clk,
  TX_EN,
  TX_DATA,
  TX_STATUS,
  UART_TX
);

input clk,TX_EN,TX_DATA;
output TX_STATUS,UART_TX;

reg [4:0] state=4'b0000;

always @(posedge clk) begin
  if(TX_EN) begin
    TX_STATUS<=0;
    state<=4'b0001;
  end
  else if(state==4'd9) begin
    state<=0;
  end
  else begin
    if(~state) begin
      TX_STATUS<=1;
      UART_TX=TX_DATA[state-1];
      state<=state+1;
    end
  end
end

endmodule // transmitter