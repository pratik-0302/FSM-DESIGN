// Code your design here
module vending_machine(
  input clk,
  input rst,
  input [1:0] in, // 01 = 5rs and 10 = 10rs
  output reg out,
  output reg [1:0] change
);
  
  parameter s0 = 2'b00;
  parameter s1 = 2'b01;
  parameter s2 = 2'b10;
  
  reg [1:0] c_state, n_state;
  
  always @(posedge clk) begin 
    if (rst == 1) begin 
      c_state <= s0;
      n_state <= s0;
      out <= 0;
      change <= 2'b00;
    end else begin
      c_state <= n_state;
    end
  end
  
  always @(*) begin
    out = 0;
    change = 2'b00;
    
    case (c_state)
      s0: begin // 0rs
        if (in == 2'b00) begin
          n_state = s0;
        end else if (in == 2'b01) begin
          n_state = s1;
        end else if (in == 2'b10) begin
          n_state = s2;
        end else begin
          n_state = s0;
        end
      end

      s1: begin // 5rs
        if (in == 2'b00) begin
          n_state = s0;
          change = 2'b01; // return 5rs
        end else if (in == 2'b01) begin
          n_state = s2;
        end else if (in == 2'b10) begin
          n_state = s0;
          out = 1;
        end else begin
          n_state = s1;
        end
      end

      s2: begin // 10rs
        if (in == 2'b00) begin
          n_state = s0;
          change = 2'b10; // return 10rs
        end else if (in == 2'b01) begin
          n_state = s0;
          out = 1;
        end else if (in == 2'b10) begin
          n_state = s0;
          out = 1;
          change = 2'b01; // 10 + 10 = 20, return 5rs
        end else begin
          n_state = s2;
        end
      end

      default: n_state = s0;
    endcase
  end

endmodule
