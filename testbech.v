module vending_machine_tb;

  // Inputs
  reg clk;
  reg rst;
  reg [1:0] in;

  // Outputs
  wire out;
  wire [1:0] change;

  // Instantiate the Unit Under Test (UUT)
  vending_machine uut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out),
    .change(change)
  );

  // Clock generation: 10ns period
  always #5 clk = ~clk;

  // Stimulus block
  initial begin
    $dumpfile("vending_machine.vcd");
    $dumpvars(1, vending_machine_tb); // Dump everything

    // Initial values
    clk = 0;
    rst = 1;
    in = 2'b00;

    #10 rst = 0;

    // Insert ₹5 + ₹5 + ₹5 = ₹15
    #10 in = 2'b01; // ₹5
    #10 in = 2'b01; // ₹5
    #10 in = 2'b01; // ₹5 → should vend
    #10 in = 2'b00;

    // ₹10 + ₹5 = ₹15
    #10 in = 2'b10;
    #10 in = 2'b01; // should vend
    #10 in = 2'b00;

    // ₹10 + ₹10 = ₹20 → should vend + 5rs change
    #10 in = 2'b10;
    #10 in = 2'b10;
    #10 in = 2'b00;

    // Finish simulation
    #20 $finish;
  end

endmodule
