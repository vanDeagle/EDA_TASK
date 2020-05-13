iverilog -o SEQ_DETECTOR_SIM sim.v ../sourcecode/SEQ_DETECTOR_fjl.v ./golden/* ./model/* ./tsk/*

vvp -n SEQ_DETECTOR_SIM -lxt2


