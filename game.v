module game(clk, p1, p2, st, reset, toIDLE, win1, win2, state, err, pos);
	input clk, p1, p2;
	input[1:0] st;
	input reset, toIDLE;
	output reg win1, win2;
	output reg[1:0] state;
	output reg err;
	output reg[3:0] pos;
	
	parameter IDLE = 0, LEFT = 1, RIGHT = 2, WAIT = 3;
	parameter MT = 819;	//0.1*819
	
	reg[1:0] t1, t2;
	wire pedge1, pedge2;
	reg[9:0] cnt;
	
	initial begin
		t1 = 0; t2 = 0;
		state = 0;
	end
	
	always@(posedge clk) begin
		t1[1] <= t1[0]; t1[0] <= p1;
		t2[1] <= t2[0]; t2[0] <= p1;
	end
	assign pedge1 = (!t1[1]) & t1[0];
	assign pedge2 = (!t2[1]) & t2[0];
	
	
	always@(posedge clk) begin
		if(reset) begin
			cnt <= 0;
			win1 <= 0; win2 <= 0;
			state <= IDLE;
		end else begin
			case(state)
				IDLE: begin
					win1 <= 0; win2 <= 0;
					err <= 0; 
					if(pedge1) begin
						if(st == 1) err <= 1;
						else begin
							pos <= 1;
							cnt <= 0;
							state <= RIGHT;
						end
					end
					if(pedge2) begin
						if(st == 0) err <= 1;
						else begin
							pos <= 8;
							cnt <= 0;
							state <= LEFT;
						end
					end
				end
				
				LEFT: begin
					if(pedge1) state <= RIGHT;
					
					if(cnt < MT) cnt <= cnt + 1;
					else begin
						cnt <= 0;
						if(pos == 1) begin
							state <= WAIT;
							win2 <= 1;
						end
						else pos <= pos - 1;
					end
				end
				
				RIGHT: begin
					if(pedge2) state <= LEFT;
					
					if(cnt < MT) cnt <= cnt + 1;
					else begin
						cnt <= 0;
						if(pos == 8) begin
							state <= WAIT;
							win1 <= 1;
						end
						else pos <= pos + 1;
					end
				end
				
				WAIT: begin
					if(toIDLE) state <= IDLE;
				end
			endcase
		end
	end
endmodule

