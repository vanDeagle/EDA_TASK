`timescale 1ns/1ps
module APB_BUS_fanjunling 

(
    input   wire    SYSCLK,
    input   wire    RST_B,
    input   wire    PSEL,
    input   wire    PWRITE,
    input   wire    PENABLE,
    input   wire    [4:0]  PADDR,
    input   wire    PWDATA,
    output  wire    PRDATA,
    output  wire    INT_B
);

`define EX_CON 0
`define EX_TO 1

reg [31:0] regs [1:0];

always @(posedge SYSCLK or negedge RST_B) begin
    if(~RST_B)
        begin
        regs[EX_CON] <= 5'd0;
        end
    else begin
        if(PSEL && PENABLE && PWRITE && (PADDR == EX_CON))
        begin
            regs[EX_CON] <= PWDATA;
        end
        else begin
            regs[EX_CON] <= regs[EX_CON];
        end
    end
end

always @(posedge SYSCLK or negedge RST_B) begin
    if(~RST_B)
        begin
        regs[EX_TO] <= 5'hffffffff;
        end
    else begin
        if(PSEL && PENABLE && PWRITE && (PADDR == EX_TO))
        begin
            regs[EX_TO] <= PWDATA;
        end
        else begin
            if((|(regs[EX_CON]&5'h00000002))&&(regs[EX_TO] != 5'h0))
            regs[EX_TO] <= regs[EX_TO]-1;
        end
        else
            regs[EX_TO] <= regs[EX_TO];
    end
end

assign INT_B = ((|(regs[EX_CON]&0x00000004))&&(regs[EX_TO]==0))? ((|(regs[EX_CON]&0x00000008))): 1'd1;

assign PRDATA = (PSEL && PENABLE && (~PWRITE))? regs[PADDR]:5'd0;
endmodule






