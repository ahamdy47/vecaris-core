module control_unit(
	input [3:0] opcode,
	input z_flag, c_flag,
	output reg [2:0] alu_op,
	output reg [1:0]wr_data_sel, pc_sel,
	output reg rd_addr_sel, reg_wr_en, mem_wr_en, z_en, c_en,
	output reg print_en,
	output reg end_sig
	);

	always @* begin
		case(opcode)
			4'b0000: begin 			// HALT
				alu_op = 3'b000;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b0;
				mem_wr_en = 1'b0;
				z_en = 1'b0;
				c_en = 1'b0;
				print_en = 1'b0;
				end_sig = 1'b1;
			end
			4'b0001: begin 			// ADD
				alu_op = 3'b000;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b1;
				mem_wr_en = 1'b0;
				z_en = 1'b1;
				c_en = 1'b1;
				print_en = 1'b0;
				end_sig = 1'b0;
			end

			4'b0010: begin 			// SUB
				alu_op = 3'b001;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b1;
				mem_wr_en = 1'b0;
				z_en = 1'b1;
				c_en = 1'b1;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b0011: begin 			// NOT			
				alu_op = 3'b010;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b1;
				mem_wr_en = 1'b0;
				z_en = 1'b1;
				c_en = 1'b1;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b0100: begin 			// SL
				alu_op = 3'b011;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b1;
				mem_wr_en = 1'b0;
				z_en = 1'b1;
				c_en = 1'b1;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b0101: begin 			// SR
				alu_op = 3'b100;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b1;
				mem_wr_en = 1'b0;
				z_en = 1'b1;
				c_en = 1'b1;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b0110: begin 			// AND
				alu_op = 3'b101;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b1;
				mem_wr_en = 1'b0;
				z_en = 1'b1;
				c_en = 1'b1;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b0111: begin 			// OR
				alu_op = 3'b110;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b1;
				mem_wr_en = 1'b0;
				z_en = 1'b1;
				c_en = 1'b1;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b1000: begin 			// ZLE
				alu_op = 3'b111;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b1;
				mem_wr_en = 1'b0;
				z_en = 1'b1;
				c_en = 1'b1;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b1001: begin 			// ST
				alu_op = 3'b000;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b1;
				reg_wr_en = 1'b0;
				mem_wr_en = 1'b1;
				z_en = 1'b0;
				c_en = 1'b0;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b1010: begin 			// LD	
				alu_op = 3'b000;
				wr_data_sel = 2'b01;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b1;
				mem_wr_en = 1'b0;
				z_en = 1'b0;
				c_en = 1'b0;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b1011: begin 			// LDI
				alu_op = 3'b000;
				wr_data_sel = 2'b10;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b1;
				mem_wr_en = 1'b0;
				z_en = 1'b0;
				c_en = 1'b0;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b1100: begin 			// BZ
				alu_op = 3'b000;
				wr_data_sel = 2'b00;
				pc_sel = 2'b10;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b0;
				mem_wr_en = 1'b0;
				z_en = 1'b0;
				c_en = 1'b0;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b1101: begin 			// J
				alu_op = 3'b000;
				wr_data_sel = 2'b00;
				pc_sel = 2'b01;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b0;
				mem_wr_en = 1'b0;
				z_en = 1'b0;
				c_en = 1'b0;
				print_en = 1'b0;
				end_sig = 1'b0;
			end
			4'b1110: begin 			// PRT
				alu_op = 3'b000;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b0;
				mem_wr_en = 1'b0;
				z_en = 1'b0;
				c_en = 1'b0;
				print_en = 1'b1;
				end_sig = 1'b0;
			end
			default: begin
				alu_op = 2'b00;
				wr_data_sel = 2'b00;
				pc_sel = 2'b00;
				rd_addr_sel = 1'b0;
				reg_wr_en = 1'b0;
				mem_wr_en = 1'b0;
				z_en = 1'b0;
				c_en = 1'b0;
				end_sig = 1'b0;
			end
		endcase
	end
endmodule