module registers(
	input clk,
	input reg_wr_en,
	input [3:0] reg_wr_addr,
	input [15:0] reg_wr_data,
	input [3:0] reg_rd_addr_1,
	output [15:0] reg_rd_data_1,
	input [3:0] reg_rd_addr_2,
	output [15:0] reg_rd_data_2
	);

	reg [15:0] reg_array [15:0];
	integer i;

	assign reg_rd_data_1 = reg_array[reg_rd_addr_1];
	assign reg_rd_data_2 = reg_array[reg_rd_addr_2];

	initial begin
		for(i=0; i<16; i=i+1)
			reg_array[i] <= 16'd0;
	end

	always @ (posedge clk) begin
		if(reg_wr_en) begin
			reg_array[reg_wr_addr] <= reg_wr_data;
		end
	end

	
endmodule