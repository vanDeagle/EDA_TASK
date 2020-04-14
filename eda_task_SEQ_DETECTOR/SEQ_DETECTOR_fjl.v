



module SEQ_DETECTOR_fjl(
			input RST_B,
			input SYSCLK,
			input IN_VALID,
			input [1:0] MODE,
			input [3:0] DATA_IN,
			output  OUT_VALID,
			output  [3:0] DATA_OUT
			);
`include "./parameters.v"
reg [4:0] current_status;
reg [4:0] next_status;
reg  [3:0] current_number;
reg [3:0] last_number;


always@(posedge SYSCLK or negedge RST_B)
begin
	if(!RST_B)
		last_number <= 4'b0;
	else if(IN_VALID)
		last_number <= current_number;
	else
		last_number <= 0;
end
//assign current_number = DATA_IN;
always@(posedge SYSCLK or negedge RST_B)
begin
	if(!RST_B)
		current_number <= 4'b0;
	else if(IN_VALID)
		current_number <= DATA_IN;
	else
		current_number <= 0;
end
always@(posedge SYSCLK or negedge RST_B)
begin
	if(!RST_B)
		
		current_status <= sequence0_status0;
	
	else
		current_status <= next_status;

end

always@(posedge SYSCLK or negedge RST_B)
begin
	if(!RST_B)
		next_status <= sequence0_status0;
	else
		case(MODE)
			mode0:
			begin
				case(current_status)
					sequence0_status0: next_status = sequence0_status1;
					sequence0_status1: next_status = (current_number == last_number+1)? sequence0_status2:sequence0_status1;
					sequence0_status2: next_status = (current_number == last_number+1)? sequence0_status3:sequence0_status2;
					sequence0_status3: next_status = sequence0_status1;
					//sequence0_status4: next_status = sequence0_status1;
					default:next_status <= sequence0_status1;
				endcase

				
			end
			mode1:
			begin
				case(next_status)
					sequence1_status0: next_status = sequence1_status1;
					sequence1_status1: next_status = (current_number == last_number-1)? sequence1_status2:sequence1_status1;
					sequence1_status2: next_status = (current_number == last_number-1)? sequence1_status3:sequence1_status2;
					sequence1_status3: next_status = sequence1_status1;
					//sequence1_status4: next_status = sequence1_status1;
					default:next_status <= sequence1_status1;
				endcase
			end
			mode2:
			begin
				case(current_status)
					sequence2_status0: next_status = sequence2_status1;
					sequence2_status1: next_status = (current_number == last_number)? sequence2_status2:sequence2_status1;
					sequence2_status2: next_status = (current_number == last_number)? sequence2_status3:sequence2_status2;
					sequence2_status3: next_status = sequence2_status1;
					//sequence2_status4: next_status = sequence2_status1;
					default:next_status <= sequence2_status1;
				endcase
			end
			mode3:
			begin
				next_status <= sequence0_status0;
			end
			default:
			begin
				next_status <= sequence0_status0;
			end
		endcase
end

/*always@(posedge SYSCLK or negedge RST_B)
begin
	if(!RST_B)
		OUT_VALID <= 1'b0;
	else
		if(next_status == sequence0_status3)
			OUT_VALID <= 1'b1;
		else if(next_status == sequence1_status3)
			OUT_VALID <= 1'b1;
		else if(next_status == sequence2_status3)
			OUT_VALID <= 1'b1;
		else
			OUT_VALID <= 1'b0;
end
*/
assign OUT_VALID = ((next_status == sequence1_status3)&&(DATA_IN == last_number-1))
					||((next_status == sequence2_status3)&&(DATA_IN == last_number))
					||((next_status == sequence0_status3)&&(DATA_IN == last_number+1));


assign DATA_OUT = OUT_VALID? DATA_IN : 4'b0;






endmodule
