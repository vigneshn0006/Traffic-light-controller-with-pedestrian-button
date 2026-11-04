// Code your design here
`timescale 1ns/1ps 
`include "clk_div.v"
`include "count5.v"
`include "count2.v"
module traffic(input sysclk, en,ped_req ,output reg [3:0]R,Y,G,ped_sig);
  parameter s0=4'b0000, s1=4'b0001, s2=4'b0010, s3=4'b0011, s4=4'b0100, s5=4'b0101, s6=4'b0110, s7=4'b0111, pedesState=4'b1000;
  reg count5En,count2En;
  reg ped_ack,flag=1'b0;
  wire trigger5,trigger2,clk;
  reg [3:0] state,nextstate,state2;
  clk_div dut0(sysclk, en,clk);
  count5 dut1(sysclk,count5En,trigger5);
  count2 dut2(sysclk,count2En,trigger2);
  always@(*) begin
    if(en) begin
      case(state) 
        s0: begin
          	ped_sig=4'b0000;
            R=4'b1110;
            Y=4'b0000;
            G=4'b0001;
        end
        s1: begin
          	ped_sig=4'b0000;
            R=4'b1100;
            Y=4'b0011;
            G=4'b0000;
        end
        s2: begin
            ped_sig=4'b0000;
            R=4'b1101;
            Y=4'b0000;
            G=4'b0010;
        end
        s3: begin
          ped_sig=4'b0000;
            R=4'b1001;
            Y=4'b0110;
            G=4'b0000;
        end
        s4: begin
          ped_sig=4'b0000;
            R=4'b1011;
            Y=4'b0000;
            G=4'b0100;
        end
        s5: begin
          ped_sig=4'b0000;
            R=4'b0011;
            Y=4'b1100;
            G=4'b0000;
        end
        s6: begin
          ped_sig=4'b0000;
            R=4'b0111;
            Y=4'b0000;
            G=4'b1000;
        end
        s7: begin
          ped_sig=4'b0000;
            R=4'b0110;
            Y=4'b1001;
            G=4'b0000;
        end
        pedesState: begin
            ped_sig=4'b1111;
             R=4'b1111;
          	 Y=4'b0000;
          	 G=4'b0000;
        end
        default: begin
          R=4'b1111;
          G=4'b1111;
          Y=4'b1111;
        end
      endcase
      end
    else begin
      R=4'b1111;
      Y=4'b0000;
      G=4'b0000;
    end
  end
  always@(posedge sysclk) begin
    if(ped_req) ped_ack<=1'b1;
    if(!en) begin
      state<=s0;
      nextstate<=s0;
      count5En<=1'b0;
      count2En<=1'b0;
      ped_ack<=1'b0;
    end
   else begin
     if(ped_ack && !flag) begin
        state2<=nextstate;
        nextstate<=pedesState;
       flag<=1'b1;
      end
      case(state)
         s0: begin
          if(trigger5)begin
            state<=nextstate;
            count5En<=1'b0;
          end
          else begin
            count5En<=1'b1;
            if(!ped_ack) nextstate<=s1;
          end
        end
        s1: begin
          if(trigger2) begin
            state<=nextstate;
            count2En<=1'b0;
          end
          else begin
            count2En<=1'b1;
            if(!ped_ack) nextstate<=s2;
          end
        end
        s2: begin
          if(trigger5)begin
            state<=nextstate;
            count5En<=1'b0;
          end
          else begin
            count5En<=1'b1;
            if(!ped_ack) nextstate<=s3;
          end
        end
        s3: begin
          if(trigger2) begin
            state<=nextstate;
            count2En<=1'b0;
          end
          else begin
            count2En<=1'b1;
            if(!ped_ack) nextstate<=s4;
          end
        end
        s4: begin
          if(trigger5)begin
            state<=nextstate;
            count5En<=1'b0;
          end
          else begin
            count5En<=1'b1;
            if(!ped_ack) nextstate<=s5;
          end
        end
        s5: begin
          if(trigger2) begin
            state<=nextstate;
            count2En<=1'b0;
          end
          else begin
            count2En<=1'b1;
            if(!ped_ack) nextstate<=s6;
          end
        end
        s6: begin
          if(trigger5)begin
            state<=nextstate;
            count5En<=1'b0;
          end
          else begin
            count5En<=1'b1;
            if(!ped_ack) nextstate<=s7;
          end
        end
        s7: begin
          if(trigger2) begin
            state<=nextstate;
            count2En<=1'b0;
          end
          else begin
            count2En<=1'b1;
            if(!ped_ack) nextstate<=s0;
          end
        end
        pedesState: begin
          if(trigger5) begin
            ped_ack<=1'b0;
            state<=nextstate;
            count5En<=1'b0;
            flag<=1'b0;
          end
          else begin
          	 count5En<=1'b1;
             nextstate<=state2;
          end
        end
        default: begin
          state<=s0;
          nextstate<=s0;
        end
      endcase
    end
  end
endmodule