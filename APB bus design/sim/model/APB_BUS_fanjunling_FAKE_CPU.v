`timescale 1ns/1ps
module APB_BUS_fanjunling_FAKE_CPU 
(
    input wire SYSCLK,
    output reg RST_B,
    output reg PSEL,
    output reg PWRITE,
    output reg PENABLE,
    output reg [4:0] PADDR,
    output reg PWDATA
);

//task1
task init;

begin
    RST_B = 1;
    PSEL = 0;
    PWRITE = 0;
    PENABLE = 0;
    PADDR = 5'd0;
    PWDATA = 5'd0;
end

endtask

//task2
task reset;

input [7:0] rest_time;

begin
    RST_B = 0;
    #rest_time
    RST_B = 1;
end

endtask

//task3
task write_reg;

input [4:0] addr;
input [31:0] data_w;

@(posedge SYSCLK)
begin
    PADDR = addr;
    PWRITE = 1;
    PSEL = 1;  
    PWDATA = data_w;  
end
#1

@(posedge SYSCLK)
begin
    PENABLE = 1;    
end
#1

@(posedge SYSCLK)
begin
    PENABLE = 0;
    PADDR = 0;
    PWRITE = 0;
    PSEL = 0;
    PWDATA = 0;
end

endtask

//task4
task read_reg;

input [4:0] addr;

@(posedge SYSCLK)
begin
    PADDR = addr;
    PWRITE = 0;
    PSEL = 1;    
end
#1

@(posedge SYSCLK)
begin
    PENABLE = 1;    
end
#1

@(posedge SYSCLK)
begin
    PENABLE = 0;
    PADDR = 0;
    PWRITE = 0;
    PSEL = 0;
end

endtask


endmodule  //APB_BUS_fanjunling_FAKE_CPU