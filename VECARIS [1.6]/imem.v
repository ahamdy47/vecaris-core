module instruction_memory(
	input [15:0] pc,
	output  [15:0] instruction
	);
	
	reg [16 - 1:0] memory [1024 - 1:0];
	wire [9:0] mem_addr = pc [9:0];
	integer i;
	
	initial begin
		for(i=0; i<256; i=i+1)
			memory[i] = 16'd0;
		$readmemh("i.mem", memory);
	end
	
	assign instruction = memory[mem_addr];
endmodule