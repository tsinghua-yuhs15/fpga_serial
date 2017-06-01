`timescale 1ns/1ns

module test;
  reg clk,reset,UART_RXD;
  wire UART_TXD;
  top tp(.clk(clk),.reset(reset),.UART_RXD(UART_RXD),.UART_TXD(UART_TXD));

  initial begin
    clk<=0;
    reset<=0;
    #100 reset<=1;
    UART_RXD<=1;
  end
  always #10 clk<=~clk;

  always #104160 UART_RXD<=~UART_RXD;

endmodule // test