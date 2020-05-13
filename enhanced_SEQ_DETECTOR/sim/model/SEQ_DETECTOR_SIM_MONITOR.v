`timescale 1ns/1ps
module SEQ_DETECTOR_SIM_MONITOR(
            input SYSCLK	,
	        input RST_B	,
	        input IN_VALID	,
	        input [1:0] MODE	,
	        input [3:0] DATA_IN	,
            //port_dut_out
	        input [3:0] DATA_OUT,
	        input OUT_VALID,
            //port_golden_out
            input [3:0] DATA_OUT_G,
            input OUT_VALID_G
);

reg [7:0] error_count = 0;
//reg [15:0] error_time [0:255];
wire [9:0] error_flag;
wire error;
assign error = |error_count;

assign error_flag = {DATA_OUT,OUT_VALID}
                    ^{DATA_OUT_G,OUT_VALID_G};

always@(posedge SYSCLK)
begin
    if(error_flag)
    begin
        $display("error occured at %t",$time);
        error_count = error_count + 1;
        //error_time[error_count] = $time;
        $display("-----error = %d",error_count); 

    end
    
end


endmodule  //time_sim_moni