module triphasic_gen(
clk,
sclk,
enable,
reset,
A,
B,
C
);


parameter INTERPHASE=10;
parameter PHASE=100;

parameter INTERPULSE=50;
parameter INTERTRAIN=
parameter REPS=100000;
parameter LONG_GAP=5000000;

parameter REPS_LENGTH = $clog2(REPS);
parameter COUNTER_LENGTH = 16;
parameter LONG_GAP_LENGTH = $clog2(LONG_GAP);

localparam IDLE=0;
localparam POS=1;
localparam GAP1=2;
localparam NEG=3;
localparam GAP2=4;
localparam POS2=5
localparam GAP3=6;
localparam GAP4=7;




input clk,enable,reset;
output A,B,C;

reg [2:0] state,nstate;
reg [COUNTER_LENGTH-1:0] phase_count;
reg [LONG_GAP_LENGTH-1:0] gap_count;
reg [REPS_LENGTH-1:0] rep_count;
reg increment;

always @*
begin
	case (state)
		IDLE: 	nstate = enable ? POS : IDLE;
		POS:	nstate = (phase_count==PHASE) ? GAP1 : POS; 
		GAP1:	nstate = (gap_count==INTERPHASE) ? NEG : GAP1;
		NEG:	nstate = (phase_count==2*PHASE) ? GAP2 : NEG;
		GAP2:	nstate = (gap_count==INTERPHASE) ? POS2 : GAP2;
		POS2:	nstate = (phase_count==PHASE) ? GAP3 : POS2; 
		GAP3:	nstate = ~enable ? IDLE : (rep_count==REPS) ? GAP4 : (gap_count==INTERPULSE) ? POS : GAP3;
		GAP4: 	nstate = ~enable ? IDLE : (gap_count==LONG_GAP) ? POS : GAP4;
		default: nstate=IDLE;
	endcase

end


always @(posedge clk or negedge reset)
begin
	if (~reset) state <= IDLE;
	else
	begin
		state <=nstate;
		case (state)
			IDLE:
			begin
				phase_count<=0;
				rep_count<=0;
				gap_count<=0;
				increment<=1;
			end
			POS:
			begin
				phase_count<=phase_count+1;
				gap_count<=0;
				rep_count<=rep_count+increment;
				increment<=0;
			end
			GAP1:
			begin
				phase_count<=0;
				gap_count<=gap_count+1;
				increment<=1;
			end
			NEG:
			begin
				phase_count<=phase_count+1;
				gap_count<=0;
			end
			GAP2:
			begin
				phase_count<=0;
				gap_count<=gap_count+1;
			end
			POS2:
			begin
				phase_count<=phase_count+1;
				gap_count<=0;
			end
			GAP3:
			begin
				phase_count<=0;
				gap_count<=gap_count+1;
			end
			GAP4:
			begin
				phase_count<=0;
				gap_count<=gap_count+1;
				rep_count<=0;
			end
		endcase
		
	end

end


assign A = (state==POS) || (state=={POS2);
assign B = (state==NEG);
assign C = (state~=POS) && (state~=NEG) && (state~=POS2);


endmodule