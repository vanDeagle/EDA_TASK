`timescale 1ns/1ps

`define init APB_BUS_fanjunling_tb.FAKE_CPU.init
`define reset APB_BUS_fanjunling_tb.FAKE_CPU.reset
`define write_reg APB_BUS_fanjunling_tb.FAKE_CPU.write_reg
`define read_reg APB_BUS_fanjunling_tb.FAKE_CPU.read_reg
module testcase 
(

);

initial
begin
    `reset(10);
    `init();
    @(posedge APB_BUS_fanjunling_tb.SYSCLK);
    `write_reg(0x00,0xff);
    #20
    `read_reg(0x00);
    #50
    `write_reg(0x01,0x64);//set timer 100
    `write_reg(0x00,0x06);//cnt start
    #200
    $finish;
end


endmodule  //testcase