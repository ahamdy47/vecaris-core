module data_memory(
	input clk,
	input [7:0] mem_addr,
	input mem_wr_en,
	input [15:0] mem_wr_data,
	output [15:0] mem_rd_data,
	input print_en
	);
	
	reg [15:0] memory [255:0];
	integer i, id;
	
	initial begin
		for(i=0; i<256; i=i+1)
			memory[i] <= 16'd0;
		$readmemh("d.mem", memory);
		id = 0;
	end

	always @ (*) begin
		if(mem_wr_en) memory[mem_addr] = mem_wr_data;
		if(print_en == 1'b1) begin
			id = $fopen("d.out", "w");
			for(i=0; i<256; i=i+1)
				 $fwrite(id, "%4x\n", memory[i]);
			$fclose(id);
		end
	end

	assign mem_rd_data =  memory[mem_addr];
endmodule