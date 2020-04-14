`timescale 1 ns/ 100 ps
module TIMER_fjl_tb;

//reg count_flag;
reg clk = 0;
reg rst = 0;
reg [2:0] minute_in = 3'd0;
reg [5:0] second_in = 6'd0;
reg start = 0;
wire [2:0] minute_out;
wire [5:0] second_out;
wire time_up;

always begin #5 clk = ~clk; end

initial 
begin
    rst = 0;
    start = 0;
    //count_flag = 0;
    minute_in = 3'd0;
    second_in = 3'd0;

    #10
    rst = 1;
    
    #5
    start = 1;
    minute_in = 3'd3;
    second_in = 6'd48;

    #5
    start = 1;

    #1000000
    $finish;
end

TIMER_fjl TIMER_fjl_test(
                        .SYSCLK(clk),
                        .RST_B(rst),
                        .START(start),
                        .TIME_MIN(minute_in),
                        .TIME_SEC(second_in),
                        .MINUTE(minute_out),
                        .SECOND(second_out),
                        .TIME_UP(time_up)
                            );

initial
$monitor("At time :%t,%d,%d",$time,minute_out,second_out);

initial
begin
    $dumpfile("TIMER_fjl_test.vcd");
    $dumpvars(0,TIMER_fjl_test);
end

endmodule



