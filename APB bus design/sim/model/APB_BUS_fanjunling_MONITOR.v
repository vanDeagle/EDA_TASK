`timescale 1ns/1ps
module APB_BUS_fanjunling_MONITOR 

(
                input SYSCLK,
                input PRDATA,
                input INT_B,
                input PRDATA_G,
                input INT_B_G
);

reg [7:0] error_count = 0;
//reg [15:0] error_time [0:255];
wire [9:0] error_flag;
wire error;
assign error = |error_count;

assign error_flag = {PRDATA,INT_B}
                    ^{PRDATA_G,INT_B_G};

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

endmodule  //