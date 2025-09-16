module register(
  input logic clk, load,
  input logic [3:0] in,
  output logic [3:0] out
  );

    always_ff @(posedge clk) begin
      if (load)
         out <= in;
      end
endmodule
