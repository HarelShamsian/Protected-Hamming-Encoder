module testbench;

  reg clk = 0;
  always #5 clk = !clk;
  
  reg [3:0] user_data;
  reg user_code;
  reg reset;
  
  wire fsm_in, fsm_out, load_enable;
  wire [3:0] reg_in, reg_out, hamming_in;
  wire [6:0] hamming_out;
  
  assign reg_in = user_data;
  assign fsm_in = user_code;
  assign load_enable = fsm_out;
  assign hamming_in = reg_out;
  
  fsm_top fsm_tb(
    .clk(clk), .x(fsm_in), .z(fsm_out), .rst(reset)
  );
  
  register register_tb(
    .clk(clk), .load(load_enable), .in(reg_in), .out(reg_out)
  );
  
  hamming hamming_tb(
    .hamming_in(hamming_in), .hamming_out(hamming_out)
  );
  
  initial begin
    reset = 1;
    #10;
    reset = 0;
    
    $display("Enter 4-bit input: ");
    user_data = $urandom % 16;
    $display("%b", user_data);
    
    $display("enter security code (1 bit per time): \n");
    while(!fsm_out) begin
      @(posedge clk);
      user_code = $urandom % 2;
      if (!fsm_out)
        $display("%b  ", user_code);
    end
    
    #10;
    
    $display("\nHamming output: %b", hamming_out);
    
    $finish;
    
  end
endmodule
