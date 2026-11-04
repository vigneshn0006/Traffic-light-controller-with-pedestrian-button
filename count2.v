//`timescale 1ns/1ps 
module count2(input clk,count2En, output reg trigger );
  parameter N=2;
  reg [21:0] count;
  always@(posedge clk)begin
    if(count2En) begin
      if(count==N) begin
        trigger<=1'b1;
        count<=0;
      end
      else begin
        count<=count+1;
        trigger=1'b0;
      end
    end
    else begin
      trigger<=1'b0;
      count<=0;
    end
  end
endmodule