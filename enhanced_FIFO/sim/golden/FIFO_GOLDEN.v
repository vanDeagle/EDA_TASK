module FIFO_GOLDEN
(
  // Input Port
  SYSCLK, RST_B, WR_EN, RD_EN, FIFO_IN,
  // Output Port
  EMPTY, FULL, FIFO_OUT
);
//=====================================================================
//   INPUT AND OUTPUT DECLARATION
//=====================================================================
input SYSCLK, RST_B, WR_EN, RD_EN;
input [7:0] FIFO_IN;
output EMPTY, FULL;
output [7:0] FIFO_OUT;
//=============================================================================
//   WIRE AND REG DECLARATION
//=============================================================================
reg [7:0] FIFO_OUT;
reg [7:0] R0, R1, R2, R3;
wire FULL, EMPTY;
//=============================================================================
//   COMBINATIONAL LOGIC
//=============================================================================
parameter DLY=1;


//=============================================================================
//   SEQUENTIAL LOGIC
//=============================================================================
reg   [2 :0]  WR_PTR;
reg   [3 :0]  WR_PTR_N;
reg   [2 :0]  RD_PTR;
reg   [3 :0]  RD_PTR_N; 
assign FULL = ((WR_PTR[1:0]==RD_PTR[1:0]) && (WR_PTR[2]==(!RD_PTR[2])));
assign EMPTY = (WR_PTR==RD_PTR);
//-----------------------------WP------------------------------------
always@(posedge SYSCLK or negedge RST_B)
    begin
    if(!RST_B)
        WR_PTR <= #DLY 3'h0;
    else 
        WR_PTR <= #DLY WR_PTR_N[2:0];
    end
always@(*)
    begin
    if(WR_EN==1 && ~FULL) 
        WR_PTR_N = WR_PTR + 1'h1;
    else
        WR_PTR_N = {1'h0, WR_PTR};
    end
    
///////////////////////////////
 always@(posedge SYSCLK or negedge RST_B)
  begin
  if (!RST_B) 
   begin
    R0 <= #DLY 0;
    R1 <= #DLY 0;
    R2 <= #DLY 0;
    R3 <= #DLY 0;
   end
   else if(WR_EN==1 && ~FULL) 
  // else if(WR_EN)    
   begin
    case(WR_PTR[1:0])
      0: R0 <= #DLY FIFO_IN;
      1: R1 <= #DLY FIFO_IN;
      2: R2 <= #DLY FIFO_IN;
      3: R3 <= #DLY FIFO_IN;
    endcase
  end
end    
//                              RP
//=====================================================================    

always@(posedge SYSCLK or negedge RST_B)
    begin
    if(!RST_B)
        RD_PTR <= #DLY 3'h0;
    else 
        RD_PTR <= #DLY RD_PTR_N[2:0];
    end
always@(*)
    begin

    if(RD_EN && ~EMPTY)
        RD_PTR_N = RD_PTR + 1'h1;
    else
        RD_PTR_N = {1'h0, RD_PTR};
    end


always@(posedge SYSCLK or negedge RST_B)
 begin
    if (!RST_B) begin
      FIFO_OUT <= #DLY 0;
     end
  else if(RD_EN && ~EMPTY) 
  begin
    case(RD_PTR[1:0])
      0: FIFO_OUT <= #DLY R0;
      1: FIFO_OUT <= #DLY R1;
      2: FIFO_OUT <= #DLY R2;
      3: FIFO_OUT <= #DLY R3;
    endcase
  end
end  

endmodule

