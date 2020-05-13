module FIFO_FAKE_CPU 

(
    input SYSCLK,
    output reg  RST_B,
    output reg WR_EN,
    output reg RD_EN,
    output reg [7:0] FIFO_IN
);

task FIFO_initial;
begin
    RST_B = 0;
    WR_EN = 0;
    FIFO_IN = 0;
    RD_EN = 0;
end
endtask

task FIFO_RST;
input [7:0] RST_TIME;
begin
RST_B = 0;
#RST_TIME;
RST_B = 1;
end
endtask

task FIFO_WRITE;
input [7:0] data0;
input [7:0] data1;
input [7:0] data2;
input [7:0] data3;

begin
    //data0
    @(posedge SYSCLK)
        WR_EN = 1;
    FIFO_IN = data0;
    #1
    @(posedge SYSCLK)
        #1
        WR_EN = 0;
    #1
    //data1
    @(posedge SYSCLK)
        WR_EN = 1;
    FIFO_IN = data1;
    #1
    @(posedge SYSCLK)
        #1
        WR_EN = 0;
    #1
    //data2
    @(posedge SYSCLK)
        WR_EN = 1;
    FIFO_IN = data2;
    #1
    @(posedge SYSCLK)
        #1
        WR_EN = 0;
    #1
    //data3
    @(posedge SYSCLK)
        WR_EN = 1;
    FIFO_IN = data3;
    #1
    @(posedge SYSCLK)
        #1
        WR_EN = 0;
    #1
    @(posedge SYSCLK)
        FIFO_IN = 0;  
end
endtask

task FIFO_READ;
begin
    //1
    @(posedge SYSCLK)
        RD_EN = 1;
    #1
    @(posedge SYSCLK)
    #1
    RD_EN = 0;
    //2
    @(posedge SYSCLK)
        RD_EN = 1;
    #1
    @(posedge SYSCLK)
    #1
    RD_EN = 0;
    //3
    @(posedge SYSCLK)
        RD_EN = 1;
    #1
    @(posedge SYSCLK)
    #1
    RD_EN = 0;
    //4
    @(posedge SYSCLK)
        RD_EN = 1;
    #1
    @(posedge SYSCLK)
    #1
    RD_EN = 0;
end
endtask

endmodule  //FIFO_FAKE_CPU