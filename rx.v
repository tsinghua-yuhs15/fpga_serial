module receiver(
  UART_RX,
  RX_DATA,
  RX_STATUS,
  reset,
  baud_clk,
);

input UART_RX,reset,baud_clk;

output RX_STATUS;
output [7:0] RX_DATA;

reg RX_STATUS;
reg [7:0] RX_DATA;
reg [7:0] state;
reg RX_EN,sample;

always @(posedge baud_clk) begin
  sample<=(state==8'd23 &&
          state==8'd39 &&
          state==8'd55 &&
          state==8'd71 &&
          state==8'd87 &&
          state==8'd103 &&
          state==8'd119 &&
          state==8'd135)?1:0;
end

always @(posedge baud_clk or negedge reset) begin
  if(~reset) begin
    state<=0;
    RX_EN<=0;
    RX_STATUS<=0;
  end
  else begin
    if(state<=8'd16) begin
      RX_STATUS<=0;
    end
    if(~UART_RX && ~RX_EN) begin
      RX_EN<=1;
      state<=0;
    end
    else if(RX_EN && state<8'd135) begin
      state<=state+1;
    end
    else if(state<=8'd143) begin
      state<=0;
      RX_EN<=0;
      RX_STATUS<=1;
    end
  end
end

always @(posedge sample) begin
  RX_DATA[6:0]<=RX_DATA[7:1];
  RX_DATA[7]<=UART_RX;
end

endmodule // 