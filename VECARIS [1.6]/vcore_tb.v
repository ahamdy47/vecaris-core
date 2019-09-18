`include "core.v"

module main();
	reg CLK;
	reg RST;
	wire [15:0] OUT;
	wire END;

	vecaris_core vcore(CLK, RST, OUT, END);

	initial begin
		$dumpfile("vcore.vcd");
		$dumpvars(0, main);
		$monitor("OUT: %d", OUT);
		CLK = 0;
		RST = 0;
	end

	always begin
		#10 CLK = ~CLK;
		if(END) $finish;
	end
endmodule