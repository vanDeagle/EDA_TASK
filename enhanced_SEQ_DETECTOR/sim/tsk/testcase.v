`timescale 1ns/1ps
`define reset sim.FAKE_CPU.reset
`define SEQ_MODE sim.FAKE_CPU.SEQ_MODE
`define SEQ_DETECTOR_initial sim.FAKE_CPU.SEQ_DETECTOR_initial
`define set_sequence sim.FAKE_CPU.set_sequence
`define SEQ_in_valid sim.FAKE_CPU.SEQ_in_valid

module testcase 

(
);


initial 
begin
    $display("--------simulation start---------");
    `SEQ_DETECTOR_initial();
    $monitor("at time %t, SEQ_DETECTOR_initial done",$time);

    #5
    `reset(5);
    $monitor("at time %t, reset done",$time);

    #55
    `set_sequence(6,7,8,9);
    `SEQ_in_valid(50);
    `SEQ_MODE(0);
    
    #60
    `set_sequence(6,5,4,3);
    `SEQ_in_valid(50);
    `SEQ_MODE(1);
    

    #60
    `set_sequence(11,11,11,11);
    `SEQ_in_valid(50);
    `SEQ_MODE(2);
    $display("r");
    #60
    `SEQ_in_valid(200);
    `set_sequence(4,5,6,7);
    `SEQ_MODE(0);
    $display("r");
    #30
    `SEQ_MODE(1);
    #10
    `set_sequence(6,5,4,5);
    #30
    `SEQ_MODE(0);
    #10
    `set_sequence(6,7,8,8);
    #30
    `SEQ_MODE(2);
    `set_sequence(8,8,8,8);
    #10
    

    if(sim.MONITOR.error == 1)
        $display("-----errors occured-----");
    else begin
        $display("-----test passed-----");
    end
    //$finish;
    #200
    $finish;
    

    
end

endmodule  //testcase