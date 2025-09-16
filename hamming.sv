module hamming(
  input logic [3:0] hamming_in,
  output logic [6:0] hamming_out
  );

      logic x3, x2, x1, x0;
      logic p1, p2, p3;

  assign {x3, x2, x1, x0} = hamming_in;

      assign p1 = x0 ^ x2 ^ x3;
      assign p2 = x0 ^ x1 ^ x3;
      assign p3 = x0 ^ x1 ^ x2;

  assign hamming_out = {p1, p2, x3, p3, x2, x1, x0};

endmodule
