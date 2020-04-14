module TIMER_fjl (
		input SYSCLK,
		input RST_B,
		input [2:0] TIME_MIN,
		input [5:0] TIME_SEC,
		input START,
		output reg [2:0] MINUTE,
		output reg [5:0] SECOND,
		output reg TIME_UP	
		);
reg flag;

always@(posedge TIME_UP,posedge START)
begin
	if(TIME_UP)
		flag <= 0;
	else
		flag =1;
end
always@(posedge SYSCLK,negedge RST_B)
begin
	if(~RST_B)
	begin
		MINUTE <= 3'd0;
		SECOND <= 6'd0;
	end
	else 
	if(flag == 1)
		if(MINUTE < TIME_MIN)
		begin
			if(SECOND == 6'd59)
			begin
				MINUTE <= MINUTE+1'b1;
				SECOND <= 3'd0;
			end
			else
			begin
				SECOND <= SECOND+1'b1;
			end
		end
		else if(MINUTE == TIME_MIN)
			if(SECOND == TIME_SEC)
			begin
				MINUTE <= MINUTE;
				SECOND <= SECOND;
			end
			else
			begin
				SECOND <= SECOND+1'b1;
			end
		else
		begin
			MINUTE <= MINUTE;
			SECOND <= SECOND;
		end
	else
		begin
			MINUTE <= MINUTE;
			SECOND <= SECOND;
		end
end


always@(posedge SYSCLK,negedge RST_B)
begin
	if(~RST_B)
		TIME_UP <= 1'b0;
	else
		if(MINUTE == TIME_MIN && SECOND == TIME_SEC)
			TIME_UP <= 1'b1;
		else
			TIME_UP <= 1'b0;
end

endmodule