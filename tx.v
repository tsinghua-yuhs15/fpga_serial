module transmitter(
  clk,
  TX_EN,
  TX_DATA,
  TX_STATUS,
  UART_TX
);

input clk,TX_EN;
input [7:0] TX_DATA;
output TX_STATUS,UART_TX;

reg [4:0] state=4'b0000;
reg TX_STATUS,UART_TX;

always @(posedge clk) begin
  if(TX_EN && ~state) begin
    TX_STATUS<=0;
    state<=4'd1;
  end
  else if(state==4'd9) begin
    state<=0;
  end
  else begin
    if(~state) begin
      TX_STATUS<=1;
      case(state)
        4'd1:UART_TX=TX_DATA[7];
        4'd2:UART_TX=TX_DATA[6];
        4'd3:UART_TX=TX_DATA[5];
        4'd4:UART_TX=TX_DATA[4];
        4'd5:UART_TX=TX_DATA[3];
        4'd6:UART_TX=TX_DATA[2];
        4'd7:UART_TX=TX_DATA[1];
        4'd8:UART_TX=TX_DATA[0];
      endcase
      state<=state+1;
    end
  end
end

endmodule // transmitter