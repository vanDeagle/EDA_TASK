module eda_task_FIFO(
                    input SYSCLK,
                    input RST_B,
                    input WR_EN,
                    input RD_EN,
                    input [7:0] FIFO_IN,
                    output reg [7:0] FIFO_OUT,
                    output  EMPTY,
                    output  FULL
);
reg [7:0] stack [3:0];

reg [1:0] cnt;

always@(posedge SYSCLK or negedge RST_B)
begin

    if(~RST_B)
    begin
        stack[0] <= 8'd0;
        stack[1] <= 8'd0;
        stack[2] <= 8'd0;
        stack[3] <= 8'd0; 
        FIFO_OUT <= 8'd0; 
        cnt <= 2'd0;   
    end

    else
        if(WR_EN && ~FULL)
        begin
            stack[0] <= FIFO_IN;
            stack[1] <= stack[0];
            stack[2] <= stack[1];
            stack[3] <= stack[2];  
            FIFO_OUT <= 8'd0;
            cnt <= cnt+1;
        end

        else if(RD_EN && ~EMPTY)
        begin
            FIFO_OUT <= stack[3];
            stack[3] <= stack[2];
            stack[2] <= stack[1];
            stack[1] <= stack[0];
            stack[0] <= 8'd0;
            cnt <= cnt-1;
        end

        else
        begin
            FIFO_OUT <= 8'd0;
        end

end

assign EMPTY = (cnt == 2'd0);
assign FULL = (cnt == 2'd3);
endmodule