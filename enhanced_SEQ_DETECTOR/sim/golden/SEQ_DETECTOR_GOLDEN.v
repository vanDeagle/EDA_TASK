//----------------------------------------------------------------------//
//  Module Name : SEQ_DETECTOR                                          //
//  Abstract    :                                                       //
//                                                                      //
//----------------------------------------------------------------------//
//  Date        : 2009-01-06						//
//  Author      : Jincai.Li						//
//----------------------------------------------------------------------//

`define DLY 1
module	SEQ_DETECTOR_GOLDEN(
	SYSCLK	,
	RST_B	,
	IN_VALID	,
	MODE	,
	DATA_IN	,
	DATA_OUT,
	OUT_VALID);

input		SYSCLK	;
input		RST_B	;
input		IN_VALID	;
input	[1:0]	MODE	;
input	[3:0]	DATA_IN	;
output	[3:0]	DATA_OUT;
output		OUT_VALID;

wire		SYSCLK	;
wire		RST_B	;
wire		IN_VALID	;
wire	[1:0]	MODE	;
wire	[3:0]	DATA_IN	;
wire	[3:0]	DATA_OUT;
wire		OUT_VALID;
wire		IN_VALID_R;
wire		RIGHT_RIS;
wire		RIGHT_FAL;
wire		RIGHT_EQU;

reg	[3:0]	REG0;
reg	[3:0]	REG1;
reg	[3:0]	REG2;

reg	[3:0]	REG0_N;
reg	[3:0]	REG1_N;
reg	[3:0]	REG2_N;

reg	[1:0]	CNT;
reg	[1:0]	CNT_N;
reg	[1:0]	MODE_DLY;
reg	[1:0]	MODE_DLY_N;
//reg	[2:0]	MODE_DLY_D;

parameter	RISING	= 2'b00;
parameter	FALLING	= 2'b01;
parameter	EQUAL	= 2'b10;

assign IN_VALID_R = (IN_VALID) && (MODE != 2'b11);
always @ (posedge SYSCLK or negedge RST_B)
begin
  if (!RST_B)
    REG0 <= #(`DLY) 4'b0000;
  else
    REG0 <= #(`DLY) REG0_N;
end
always @ (*)
begin
  if (IN_VALID_R)
    REG0_N = DATA_IN;
  else
    REG0_N = REG0;
end

always @ (posedge SYSCLK or negedge RST_B)
begin
  if (!RST_B)
    REG1 <= #(`DLY) 4'b0000;
  else
    REG1 <= #(`DLY) REG1_N;
end
always @ (*)
begin
  if (IN_VALID_R)
    REG1_N = REG0;
  else
    REG1_N = REG1;
end

always @ (posedge SYSCLK or negedge RST_B)
begin
  if (!RST_B)
    REG2 <= #(`DLY) 4'b0000;
  else
    REG2 <= #(`DLY) REG2_N;
end
always @ (*)
begin
  if (IN_VALID_R)
    REG2_N = REG1;
  else
    REG2_N = REG2;
end

always @ (posedge SYSCLK or negedge RST_B)
begin
  if (!RST_B)
    MODE_DLY <= #(`DLY) 2'b11;
//    MODE_DLY <= #(`DLY) 2'b00;
  else
    MODE_DLY <= #(`DLY) MODE_DLY_N;
end

always @ (*)
begin
  if (IN_VALID_R)
    MODE_DLY_N = MODE;
  else 
    MODE_DLY_N = MODE_DLY;
end

always @ (posedge SYSCLK or negedge RST_B)
begin
  if (!RST_B)
    CNT <= #(`DLY) 2'b00;
  else
    CNT <= #(`DLY) CNT_N;
end
always @ (*)
begin
  if (IN_VALID_R && (MODE == MODE_DLY) && (CNT != 2'b10))
    CNT_N = CNT + 1'b1;
  else if (IN_VALID_R && (MODE != MODE_DLY))
    CNT_N = 2'b00;
  else
    CNT_N = CNT;
end

assign RIGHT_EQU = (DATA_IN == REG0) && (REG0== REG1) && (REG1== REG2) 
                   && (CNT == 2'b10) && (MODE == EQUAL);
assign RIGHT_FAL = (REG0 == DATA_IN + 1'b1) && (REG1 == REG0 + 1'b1) 
                   && (REG2 == REG1 + 1'b1) && (CNT == 2'b10) && (MODE == FALLING);
assign RIGHT_RIS = (REG1 == REG2 + 1'b1) && (REG0 == REG1 + 1'b1) 
                   && (DATA_IN == REG0 + 1'b1) && (CNT == 2'b10) && (MODE == RISING);

assign OUT_VALID = (RIGHT_EQU) || (RIGHT_FAL) || (RIGHT_RIS);
assign DATA_OUT = OUT_VALID ? DATA_IN : 4'b0000;


endmodule
