module receiver(
  UART_RX,
  RX_DATA,
  RX_STATUS,
  reset,
  baud_clk,
  clk
);

input UART_RX,reset,baud_clk,clk;

output RX_STATUS;
output [7:0] RX_DATA;

reg cur_per,prev_per;
reg[4:0] state;

always @(posedge baud_clk or negedge reset) begin
  if(~reset) begin
    RX_STATUS<=0;
    cur_per<=1;
    prev_per<=1;
  end
  else if(cur_per && prev_per) begin
    RX_STATUS<=0;
    cur_per<=UART_RX;
    prev_per<=cur_per;
  end
  else if(~cur_per && prev_per) begin
    case(state)
      4'd0:RX_DATA[0]<=UART_RX;
      4'd1:RX_DATA[1]<=UART_RX;
      4'd2:RX_DATA[2]<=UART_RX;
      4'd3:RX_DATA[3]<=UART_RX;
      4'd4:RX_DATA[4]<=UART_RX;
      4'd5:RX_DATA[5]<=UART_RX;
      4'd6:RX_DATA[6]<=UART_RX;
      4'd7:begin
        RX_DATA[7]=UART_RX;
        RX_STATUS<=1;
        cur_per<=1;
        prev_per<=1;
      end
      default:begin
        RX_STATUS<=0;
        RX_DATA<=0;
        cur_per<=1;
        prev_per<=1;
      end
  end
end

always @(posedge clk or negedge reset) begin
  if(~reset) state<=0;
  else if(~cur_per && prev_per) begin
    state<=(state<4'd7)?state+4'd1:4'd0;
  end
end
endmodule // 