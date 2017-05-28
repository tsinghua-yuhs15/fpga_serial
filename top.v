module top(
  clk,
  reset,
  UART_RXD,
  UART_TXD
);

input clk,reset,UART_RXD;
output UART_TXD;

wire _clk,_baud_clk,reset,TX_EN,RX_STATUS,TX_STATUS;
wire [7:0] RX_DATA,TX_DATA;

divide d1(.rate(14'd5208),.clk_in(clk),.clk_out(_clk),.reset(reset));
divide d2(.rate(14'd326),.clk_in(clk),.clk_out(_baud_clk),.reset(reset));

receiver rxer(.UART_RX(UART_RXD),.RX_DATA(RX_DATA),.RX_STATUS(RX_STATUS),.reset(reset),.baud_clk(_baud_clk));

transmitter tser(.clk(_clk),.TX_EN(TX_EN),.TX_DATA(TX_DATA),.TX_STATUS(TX_STATUS),.UART_TX(UART_TXD));

control ct(.clk(_clk),.RX_DATA(RX_DATA),.TX_DATA(TX_DATA),.RX_STATUS(RX_STATUS),.TX_STATUS(TX_STATUS),.TX_EN(TX_EN));

endmodule // top