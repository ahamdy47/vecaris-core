`include "alu.v"
`include "imem.v"
`include "regs.v"
`include "dmem.v"
`include "ctrl.v"
`include "mux.v"

module vecaris_core(
	input clk,
	input rst,
	output reg [15:0] print_out,
	output end_sig
	);
	
	// PC datapath
	reg [15:0] pc;
	wire [15:0] pc_next, pc_plus, pc_jump, pc_branch;
	// Intsruction and Data bus
	wire [15:0] instruction;
	wire [3:0] rs1_in;
	wire [15:0] rd1_out, rd2_out, wd_in;
	wire [15:0] alu_out, mem_out;
	// Flag Reg
	reg z_flag, c_flag;
	wire z_in, c_in;
	// Control lines
	wire [2:0] alu_op;
	wire reg_wr_en, mem_wr_en;
	wire rd_addr_sel;
	wire [1:0] pc_sel, wr_data_sel;
	wire z_en, c_en;
	wire print_en;

	arithmetic_logic_unit alu(alu_op, rd1_out, rd2_out, alu_out, c_in, z_in);
	instruction_memory imem(pc, instruction);
	registers regs(clk, reg_wr_en, instruction [11:8], wd_in, rs1_in, rd1_out, instruction [3:0], rd2_out);
	data_memory dmem(clk, instruction [7:0], mem_wr_en, rd1_out, mem_out, print_en);
	control_unit ctrl(instruction [15:12], z_flag, c_flag, alu_op, wr_data_sel, pc_sel, rd_addr_sel, reg_wr_en, mem_wr_en, z_en, c_en, print_en, end_sig);
	mux_2_to_1_4bit rd_addr_mux(rd_addr_sel, instruction [7:4], instruction [11:8], rs1_in);
	mux_2_to_1_16bit br_mux(z_flag, pc_plus, pc_jump, pc_branch);
	mux_3_to_1_16bit wr_data_mux(wr_data_sel, alu_out, mem_out, {{8{instruction[7]}},instruction [7:0]}, wd_in);
	mux_3_to_1_16bit pc_mux(pc_sel, pc_plus, pc_jump, pc_branch, pc_next);

	assign pc_plus = pc + 16'd1;
	assign pc_jump = {4'b0, instruction [11:0]};

	initial begin
		pc <= 16'd0;
		print_out <= 16'd0;
		z_flag <= 1'b0;
		c_flag <= 1'b0;
	end

	always @(posedge rst) begin
		pc <= 16'd0;
		print_out <= 16'd0;
		z_flag <= 1'b0;
		c_flag <= 1'b0;
	end

	always @(posedge clk) begin
		pc <= pc_next;
		if(z_en)
			z_flag <= z_in;
		if(c_en)
			c_flag <= c_in;
		if(print_en == 1'b1)
			print_out <= mem_out;
	end
endmodule