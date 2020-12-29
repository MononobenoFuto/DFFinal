module score(clk, win1, win2, kick, reset, sc1, sc2, tsc1, tsc2, st, toIDLE);
	input clk, win1, win2, kick, reset;
	output reg[2:0] sc1, sc2;
	output reg[2:0] tsc1, tsc2;
	output reg[1:0] st;
	output reg toIDLE;
	
	reg cnt;
	reg [1:0] t1, t2;
	wire pedge1, pedge2;
	
	initial begin
		st = 2;
		t1 = 0; t2 = 0;
	end
	
	always @(posedge clk) begin
		t1[1] <= t1[0];
		t1[0] <= win1;
		t2[1] <= t2[0];
		t2[0] <= win2;
	end
	assign pedge1 = (!t1[1]) & t1[0];
	assign pedge2 = (!t2[1]) & t2[0];
	
	always @(posedge clk) begin
		if(st == 2) begin
			if(kick) begin
				//st = {$random} % 2;
				st = 1;
			end
		end else
		begin
		
		end
	end
endmodule
