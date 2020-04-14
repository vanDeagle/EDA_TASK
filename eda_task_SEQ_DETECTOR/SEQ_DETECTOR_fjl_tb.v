`timescale 1ns/1ps


module SEQ_DETECTOR_fjl_tb();
reg RST_B;
reg SYSCLK;
reg IN_VALID;
reg [1:0] MODE;
reg [3:0] DATA_IN;
wire OUT_VALID;
wire [3:0] DATA_OUT;
`include "./parameters.v"
parameter time_period = 10;

SEQ_DETECTOR_fjl SEQ_DETECTOR_fjl_test(
			 RST_B,
			 SYSCLK,
		     IN_VALID,
			 MODE,
			 DATA_IN,
		     OUT_VALID,
			 DATA_OUT
			);

initial
begin
    SYSCLK = 0;
    forever
        #(time_period/2) SYSCLK = ~SYSCLK;
end

initial
begin
    RST_B = 1;
    #5 RST_B = 0;
    #6 RST_B = 1;

end

initial
begin
    IN_VALID = 0;
    #65 IN_VALID = 1;
    #50 IN_VALID = 0;
    #10 IN_VALID = 1;
    #50 IN_VALID = 0;
    #10 IN_VALID = 1;
    #50 IN_VALID = 0;
    #10 IN_VALID = 1;
end

initial
begin
    MODE = 2'd0;
    #125 MODE = 2'd1;
    #60 MODE = 2'd2;
    #60 MODE = 2'd0;
    #30 MODE = 2'd1;
    #40 MODE = 2'd0;
    #40 MODE = 2'd2;
end

initial
begin
    #1000 $finish;
end

initial
$monitor ("At time %t, mode = %d, DATA_IN = %d, OUT_VALID = %d",$time,MODE,DATA_IN,OUT_VALID);

initial
begin
    $dumpfile("SEQ_DETECTOR_fjl_test.vcd");
    $dumpvars(1,SEQ_DETECTOR_fjl_test);
end

initial
begin
    DATA_IN = 0;
    #15 DATA_IN = 2;
    #10 DATA_IN = 3;
    #10 DATA_IN = 4;
    #10 DATA_IN = 5;
    #10 DATA_IN = 0;
    #10 DATA_IN = 6;
    #10 DATA_IN = 7;
    #10 DATA_IN = 8;
    #10 DATA_IN = 9;
    #10 DATA_IN = 0;
    #20 DATA_IN = 6;
    #10 DATA_IN = 5;
    #10 DATA_IN = 4;
    #10 DATA_IN = 3;
    #10 DATA_IN = 0;
    #20 DATA_IN = 11;
    #40 DATA_IN = 0;
    #20 DATA_IN = 4;
    #10 DATA_IN = 5;
    #10 DATA_IN = 6;
    #10 DATA_IN = 7;
    #10 DATA_IN = 6;
    #10 DATA_IN = 5;
    #10 DATA_IN = 4;
    #10 DATA_IN = 5;
    #10 DATA_IN = 6;
    #10 DATA_IN = 7;
    #10 DATA_IN = 8;
end


endmodule