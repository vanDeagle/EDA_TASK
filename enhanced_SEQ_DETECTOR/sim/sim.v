`timescale 1ns/1ps


module sim();
wire RST_B;
reg SYSCLK;
wire IN_VALID;
wire [1:0] MODE;
wire [3:0] DATA_IN;
wire OUT_VALID;
wire [3:0] DATA_OUT;
wire OUT_VALID_G;
wire [3:0] DATA_OUT_G;

initial
begin
	SYSCLK = 0;
	forever #5
	begin
		SYSCLK = ~SYSCLK;
	end
end



SEQ_DETECTOR_fjl DUT(
			 .RST_B(RST_B),
			 .SYSCLK(SYSCLK),
		     .IN_VALID(IN_VALID),
			 .MODE(MODE),
			 .DATA_IN(DATA_IN),
		     .OUT_VALID(OUT_VALID),
			 .DATA_OUT(DATA_OUT)
			);

SEQ_DETECTOR_GOLDEN GOLDEN(
	        .SYSCLK(SYSCLK)	,
	        .RST_B(RST_B)	,
	        .IN_VALID(IN_VALID)	,
	        .MODE(MODE)	,
	        .DATA_IN(DATA_IN)	,
	        .DATA_OUT(DATA_OUT_G),
	        .OUT_VALID(OUT_VALID_G)
            );

SEQ_DETECTOR_SIM_MONITOR MONITOR(
            //port_in
            .SYSCLK(SYSCLK)	,
	        .RST_B(RST_B)	,
	        .IN_VALID(IN_VALID)	,
	        .MODE(MODE)	,
	        .DATA_IN(DATA_IN)	,
            //port_dut_out
	        .DATA_OUT(DATA_OUT),
	        .OUT_VALID(OUT_VALID),
            //port_golden_out
            .DATA_OUT_G(DATA_OUT_G),
            .OUT_VALID_G(OUT_VALID_G)
);
SEQ_DETECTOR_SIM_FAKE_CPU FAKE_CPU(
            .SYSCLK(SYSCLK)	,
	        .RST_B(RST_B)	,
	        .IN_VALID(IN_VALID)	,
	        .MODE(MODE)	,
	        .DATA_IN(DATA_IN)	
);



initial
begin
    $dumpfile("./waveform/SEQ_DETECTOR_SIM.vcd");
    $dumpvars(0,sim);
end


endmodule