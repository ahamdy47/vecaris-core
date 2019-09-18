module arithmetic_logic_unit(
	input [2:0] op, // change to sel
	input [15:0] a,
	input [15:0] b,
	output [15:0] s,
	output cout,
	output zero
	);

	reg [16:0] out_reg;
	reg c;

	always @ * begin 
		case(op)
			3'b000: out_reg = a + b;		// ADD
			3'b001: out_reg = a - b;		// SUB
			3'b010: out_reg[15:0] = ~a;		// NOT
			3'b011: out_reg = a << b;		// SL (Logical)
			3'b100: out_reg = a >> b;		// SR (Logical)
			3'b101: out_reg = a & b;		// AND
			3'b110: out_reg = a | b;		// OR
			3'b111: begin 					// ZLE (Set Zero if Less Than or Equal)
				if (a<=b) out_reg = 1'b0;
				else out_reg = 1'b1;
				end
			default: out_reg = a;
		endcase
	end
	
	assign zero = (out_reg == 0);
	assign s = out_reg[15:0];
	assign cout = out_reg[16];
endmodule