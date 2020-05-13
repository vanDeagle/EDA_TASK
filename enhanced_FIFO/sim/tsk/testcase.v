`define FIFO_initial sim.FAKE_CPU.FIFO_initial
`define FIFO_RST sim.FAKE_CPU.FIFO_RST
`define FIFO_WRITE sim.FAKE_CPU.FIFO_WRITE
`define FIFO_READ sim.FAKE_CPU.FIFO_READ 
module testcase
(

);

initial 
begin
    $display("--------simulation start---------");
    `FIFO_initial();
    $monitor("at time %4t, FIFI_initial done",$time);

    #5
    `FIFO_RST(10);
    $monitor("at time %4t, reset done",$time);

    #10
    `FIFO_WRITE(1,2,3,4);
    #100
    $monitor("at time %4t, FIFO_WRITE done",$time);

    `FIFO_READ();
    #100
    $monitor("at time %4t, FIFO_READ done",$time);

    #30
    

    if(sim.MONITOR.error == 1)
        $display("-----errors occured-----");
    else begin
        $display("-----test passed-----");
    end
    //$finish;
    
    $finish;
    

    
end

endmodule  //testcase