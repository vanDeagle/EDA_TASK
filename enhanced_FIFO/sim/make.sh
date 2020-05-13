iverilog -o FIFO_SIM sim.v ../sourcecode/* ./model/* ./tsk/* ./golden/* 

vvp -n FIFO_SIM -lxt2