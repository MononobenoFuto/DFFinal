module dffinal(clk, p1, p2, kick, reset, led, show, seg, alert);
	input clk, p1, p2, kick, reset;
	output [7:0] led;
	output [6:0] show;
	output [7:0] seg;
	output alert;
	wire win1, win2;
	wire [2:0] sc1, sc2;
	wire [2:0] tsc1, tsc2;
	wire [1:0] st;
	wire toIDLE;
	wire [1:0] state;
	wire err;
	wire [3:0] pos;
	score xsy(clk, win1, win2, kick, reset, sc1, sc2, tsc1, tsc2, st, toIDLE);
	game why(clk, p1, p2, reset, toIDLE, win1, win2, state, err, pos);
	show cr(clk, st, tsc1, tsc2, sc1, sc2, state, pos, er, led, show, seg, alert);
endmodule
