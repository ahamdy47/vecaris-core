module mux_2_to_1_4bit(
	input sel,
	input [3:0] in_0,
	input [3:0] in_1,
	output reg [3:0] out
	);

	always @* begin
		if(sel == 1'b0) out = in_0;
		else out = in_1;
	end
endmodule

module mux_2_to_1_16bit(
	input sel,
	input [15:0] in_0,
	input [15:0] in_1,
	output reg [15:0] out
	);

	always @* begin
		if(sel == 1'b0) out = in_0;
		else out = in_1;
	end
endmodule

module mux_3_to_1_16bit(
	input [1:0 ]sel,
	input [15:0] in_0,
	input [15:0] in_1,
	input [15:0] in_2,
	output reg [15:0] out
	);

	always @* begin
		if(sel == 2'b00) out = in_0;
		else if(sel == 2'b01) out = in_1;
		else if(sel == 2'b10) out = in_2;
	end
endmodule