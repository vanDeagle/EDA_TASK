`timescale 1ns/1ps
module FIFO_MONITOR 

(
                input SYSCLK,
                input [7:0] FIFO_OUT,
                input EMPTY,
                input FULL,
                input [7:0] FIFO_OUT_G,
                input EMPTY_G,
                input FULL_G
);

reg [7:0] error_count = 0;
//reg [15:0] error_time [0:255];
wire [9:0] error_flag;
wire error;
assign error = |error_count;

assign error_flag = {FIFO_OUT,EMPTY,FULL}
                    ^{FIFO_OUT_G,EMPTY_G,FULL_G};

always@(posedge SYSCLK)
begin
    if(error_flag)
    begin
        $display("error occured at %4t",$time);
        error_count = error_count + 1;
        //error_time[error_count] = $time;
        $display("-----error = %2d",error_count); 

    end
    
end

endmodule  //FIFO_MONITOR