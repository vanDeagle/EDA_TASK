`timescale 1ns/1ps
module sim 

(

);

reg SYSCLK;
wire RST_B;
wire WR_EN;
wire RD_EN;
wire [7:0] FIFO_IN;

wire [7:0] FIFO_OUT;
wire EMPTY;
wire FULL;

wire [7:0] FIFO_OUT_G;
wire EMPTY_G;
wire FULL_G;

initial
begin
    SYSCLK = 0;
    forever #5
        SYSCLK = ~SYSCLK;
end

//intance dut 
FIFO_fjl FIFO_fjl(
                    //in
                    .SYSCLK(SYSCLK),
                    .RST_B(RST_B),
                    .WR_EN(WR_EN),
                    .RD_EN(RD_EN),
                    .FIFO_IN(FIFO_IN),
                    //out
                    .FIFO_OUT(FIFO_OUT),
                    .EMPTY(EMPTY),
                    .FULL(FULL)
);

//instance GOLDEN
FIFO_GOLDEN FIFO_GOLDEN(
                    //in
                    .SYSCLK(SYSCLK),
                    .RST_B(RST_B),
                    .WR_EN(WR_EN),
                    .RD_EN(RD_EN),
                    .FIFO_IN(FIFO_IN),
                    //out
                    .FIFO_OUT(FIFO_OUT_G),
                    .EMPTY(EMPTY_G),
                    .FULL(FULL_G)
);

//instance FAKE_CPU
FIFO_FAKE_CPU FAKE_CPU(
                    
                    .SYSCLK(SYSCLK),
                    .RST_B(RST_B),
                    .WR_EN(WR_EN),
                    .RD_EN(RD_EN),
                    .FIFO_IN(FIFO_IN)
);

//instance monitor
FIFO_MONITOR MONITOR(    
                    .SYSCLK(SYSCLK),               
                    .FIFO_OUT(FIFO_OUT),
                    .EMPTY(EMPTY),
                    .FULL(FULL),
                    .FIFO_OUT_G(FIFO_OUT_G),
                    .EMPTY_G(EMPTY_G),
                    .FULL_G(FULL_G)
                    );

//dumfile
initial
begin
    $dumpfile("./waveform/FIFO_SIM.vcd");
    $dumpvars(0,sim);
end

endmodule  //sim