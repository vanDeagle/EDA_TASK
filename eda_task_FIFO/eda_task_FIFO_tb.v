`timescale 1ns / 1ps
module eda_task_FIFO_tb ();

reg SYSCLK;
reg RST_B;
reg WR_EN;
reg RD_EN;
reg [7:0] FIFO_IN;

wire EMPTY;
wire FULL;
wire [7:0] FIFO_OUT;

eda_task_FIFO eda_task_FIFO_test(
                SYSCLK,
                RST_B,
                WR_EN,
                RD_EN,
                FIFO_IN,
                FIFO_OUT,
                EMPTY,
                FULL
);

initial SYSCLK = 0;
always begin #5 SYSCLK = !SYSCLK; end

initial
begin
    RST_B = 0;
    #16 RST_B = 1;
end

initial
begin
    WR_EN = 0;
    RD_EN = 0;
    FIFO_IN = 8'd0;
    #26 WR_EN = 1; FIFO_IN = 8'd1; //26
    #10 WR_EN = 0; FIFO_IN = 8'd2; //36 35read1
    #10 WR_EN = 1; //FIFO_IN = 8'd3; //46
    #10 WR_EN = 0; FIFO_IN = 8'd3; //56 55read2
    #10 WR_EN = 1;                 //66
    #10 WR_EN = 0; FIFO_IN = 8'd4; //76 75read3
    #10 WR_EN = 1;
    #10 WR_EN = 0;
    #20 FIFO_IN = 0;
    #20
    RD_EN = 1; //FIFO_IN = 8'd1; //26
    #10 RD_EN = 0; //FIFO_IN = 8'd2; //36 35read1
    #10 RD_EN = 1; //FIFO_IN = 8'd3; //46
    #10 RD_EN = 0; //FIFO_IN = 8'd3; //56 55read2
    #10 RD_EN = 1;                 //66
    #10 RD_EN = 0; //FIFO_IN = 8'd4; //76 75read3
    #10 RD_EN = 1;
    #10 RD_EN = 0;

    #20 $finish;



end
initial
begin
    $dumpfile("eda_task_FIFO_test.vcd");
    $dumpvars(0,eda_task_FIFO_test);
end


endmodule