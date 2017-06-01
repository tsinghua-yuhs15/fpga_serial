module control(
  clk,
  RX_DATA,
  TX_DATA,
  RX_STATUS,
  TX_STATUS,
  TX_EN
);

input clk,RX_STATUS,TX_STATUS;
input [7:0] RX_DATA;

output TX_EN;
output [7:0] TX_DATA;

reg [7:0] TX_DATA;
reg TX_EN;
reg state;

initial begin
  state<=0;
end

always @(posedge clk) begin
  if(~state && RX_STATUS) begin
    state<=1;   
    TX_DATA[7]<=RX_DATA[7];
    TX_DATA[6:0]<=(RX_DATA[7])?~RX_DATA[6:0]:RX_DATA[6:0]; 
  end
  else if(state && TX_STATUS) begin
    TX_EN<=1;
	 state<=0;
  end 
  else if(~state) begin
    TX_EN<=0;
  end 
end
  
endmodule // control