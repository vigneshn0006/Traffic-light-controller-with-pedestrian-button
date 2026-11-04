//`timescale 1ns/1ps 
module clk_div(input sysclk,rst, output reg clk );
  parameter N=500000000;
  reg [21:0] count;
  always@(posedge sysclk)begin
    if(!rst) begin
      if(count==N) begin
        clk<=~clk;
        count<=0;
      end
      else begin
        count<=count+1;
      end
    end
    else begin
      clk<=1'b0;
      count<=0;
    end
  end
endmodule