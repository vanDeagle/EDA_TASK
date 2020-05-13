`timescale 1ns/1ps
module APB_BUS_fanjunling_tb ;

reg     SYSCLK;
wire    RST_B;
wire    PSEL;
wire    PWRITE;
wire    PENABLE;
wire    [4:0]  PADDR;
wire    PWDATA;
wire    PRDATA;
wire    INT_B;

wire    PRDATA_G;
wire    INT_B_G;

always@(*)
begin
    #5
    SYSCLK = ~SYSCLK;
end

initial
begin
    SYSCLK = 0;
end

APB_BUS_fanjunling DUT(
    .SYSCLK(SYSCLK),
    .RST_B(RST_B),
    .PSEL(PSEL),
    .PWRITE(PWRITE),
    .PENABLE(PENABLE),
    .PADDR(PADDR),
    .PWDATA(PWDATA),
    .PRDATA(PRDATA),
    .INT_B(INT_B)
);

APB_BUS_fanjunling_FAKE_CPU FAKE_CPU(
    .SYSCLK(SYSCLK),
    .RST_B(RST_B),
    .PSEL(PSEL),
    .PWRITE(PWRITE),
    .PENABLE(PENABLE),
    .PADDR(PADDR),
    .PWDATA(PWDATA)
);

APB_BUS_fanjunling_MONITOR MONITOR(
    .PRDATA(PRDATA),
    .INT_B(INT_B),
    .PRDATA_G(PRDATA_G),
    .INT_B_G(INT_B_G)
);

APB_BUS_fanjunling GOLDEN(    
    .SYSCLK(SYSCLK),
    .RST_B(RST_B),
    .PSEL(PSEL),
    .PWRITE(PWRITE),
    .PENABLE(PENABLE),
    .PADDR(PADDR),
    .PWDATA(PWDATA),
    .PRDATA(PRDATA_G),
    .INT_B(INT_B_G)
);

initial
begin
    $dumpfile("./waveform/APB_SIM.vcd");
    $dumpvars(0,APB_BUS_fanjunling_tb);
end

endmodule  //APB_BUS_fanjunling_tb