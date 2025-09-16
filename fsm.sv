//fsm
module fsm_1001(
	input logic x, q1, q0,
	output logic d1, d0, z
);
	assign d1 = !x && (q1 ^ q0);
	assign d0 = x || (q1 && !q0);
	assign z = x && q1 && q0;
endmodule

module dffs(
	input logic clk, d1, d0, rst, 
	output logic q1, q0
);
	always_ff @(posedge clk) begin
      if (rst) begin
        q1 <= 0;
      	q0 <= 0;
      end else begin
      q1 <= d1;
      q0 <= d0;
      end  
	end     
endmodule

		
module fsm_top(
	input logic clk, x, rst,
	output logic z
);
      logic d1, d0, q1, q0;

      fsm_1001 fsm_ins(
          .x(x), .d1(d1), .d0(d0), .q1(q1), .q0(q0), .z(z)
          );

      dffs dffs_ins(
        .clk(clk), .d1(d1), .d0(d0), .q1(q1), .q0(q0), .rst(rst)
          );
endmodule

