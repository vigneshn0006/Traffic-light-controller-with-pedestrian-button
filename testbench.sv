// Code your testbench here
// or browse Examples
`timescale 1ns/1ps 
module tb();
  reg sysclk,en,ped_req;
  wire [3:0]R,Y,G,ped_sig;
  traffic dut(sysclk,en,ped_req,R,Y,G,ped_sig);
  initial begin
    sysclk=1'b0;
    #1500 $finish;
  end
  always #5 sysclk=~sysclk;
  initial begin
    en=0;
    #10 en=1;
    #50 ped_req=1'b1;
    #10 ped_req=1'b0;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule