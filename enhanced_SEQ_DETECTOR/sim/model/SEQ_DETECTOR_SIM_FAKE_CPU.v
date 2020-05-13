`timescale 1ns/10ps
module SEQ_DETECTOR_SIM_FAKE_CPU(
			input SYSCLK,
			output reg RST_B,
			output reg IN_VALID,
			output reg [1:0] MODE,
			output reg [3:0] DATA_IN
			);

//reset

task reset;

input   [7:0] reset_time;
begin
RST_B = 0;
# reset_time;
RST_B = 1;
end
endtask



//initial
task SEQ_DETECTOR_initial;
begin
RST_B = 0;
IN_VALID = 0;
MODE = 0;
DATA_IN = 0;
end
endtask


//start_clock
// task start_clock;
// begin
// 	begin
//     SYSCLK - 0;
//     forever
//     begin
//         #5 SYSCLK = ~SYSCLK;
//     end
// end
// end


//set_sequence
task set_sequence;
input [3:0] number0;
input [3:0] number1;
input [3:0] number2;
input [3:0] number3;
begin
	@(posedge SYSCLK)
		DATA_IN = number0;
	#1
	@(posedge SYSCLK)
		DATA_IN = number1;
	#1
	@(posedge SYSCLK)
		DATA_IN = number2;
	#1
	@(posedge SYSCLK)
		DATA_IN = number3;
end
endtask
//invalid
task SEQ_in_valid;

input [7:0] valid_time;
begin
IN_VALID = 1;
#valid_time
IN_VALID = 0;
end

endtask

//set mode
task SEQ_MODE;
input [1:0] MODE_set;
MODE = MODE_set;
endtask
endmodule