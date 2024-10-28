module fsm (
    clk,
    reset,
    in,
    out
);
  input logic clk;
  input logic in;
  input logic reset;
  output logic out;

  logic [2:0] present_state, next_state;

  parameter bit [2:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

  always_ff @(posedge clk) begin : Register_logic

    if (reset) begin
      present_state <= S0;
    end else begin
      present_state <= next_state;
    end

  end

  always_comb begin : next_state_logic

    case (present_state)
      S0: next_state = in ? S1 : S0;
      S1: next_state = in ? S1 : S2;
      S2: next_state = in ? S3 : S0;
      S3: next_state = in ? S4 : S2;
      S4: next_state = in ? S1 : S2;
      default: next_state = S0;
    endcase

  end

  assign out = (present_state == S4);


  // Properties for present_state transitions
  property p_s0_to_s1;
    @(posedge clk) disable iff (reset) (present_state == S0 && in == 1) |=> present_state == S1;
  endproperty

  property p_s0_to_s0;
    @(posedge clk) disable iff (reset) (present_state == S0 && in == 0) |=> present_state == S0;
  endproperty

  property p_s1_to_s2;
    @(posedge clk) disable iff (reset) (present_state == S1 && in == 0) |=> present_state == S2;
  endproperty

  property p_s1_to_s1;
    @(posedge clk) disable iff (reset) (present_state == S1 && in == 1) |=> present_state == S1;
  endproperty

  property p_s2_to_s3;
    @(posedge clk) disable iff (reset) (present_state == S2 && in == 1) |=> present_state == S3;
  endproperty

  property p_s2_to_s0;
    @(posedge clk) disable iff (reset) (present_state == S2 && in == 0) |=> present_state == S0;
  endproperty

  property p_s3_to_s4;
    @(posedge clk) disable iff (reset) (present_state == S3 && in == 1) |=> present_state == S4;
  endproperty

  property p_s3_to_s2;
    @(posedge clk) disable iff (reset) (present_state == S3 && in == 0) |=> present_state == S2;
  endproperty

  property p_s4_to_s1;
    @(posedge clk) disable iff (reset) (present_state == S4 && in == 1) |=> present_state == S1;
  endproperty

  property p_s4_to_s2;
    @(posedge clk) disable iff (reset) (present_state == S4 && in == 0) |=> present_state == S2;
  endproperty

  // Output assertion
  property p_pattern_detect;
    @(posedge clk) disable iff (reset) present_state == S4 |-> out == 1;
  endproperty

  // Reset assertion
  property p_reset;
    @(posedge clk) reset |=> present_state == S0 && out == 0;
  endproperty

  // Assert all properties
  assert property (p_s0_to_s1) begin
    $display("p_s0_to_s1 assertion pass");
  end else begin
    $display("p_s0_to_s1 assertion failed");
  end

  assert property (p_s0_to_s0) begin
    $display("p_s0_to_s0 assertion pass");
  end else begin
    $display("p_s0_to_s0 assertion failed");
  end

  assert property (p_s1_to_s2) begin
    $display("p_s1_to_s2 assertion pass");
  end else begin
    $display("p_s1_to_s2 assertion failed");
  end

  assert property (p_s1_to_s1) begin
    $display("p_s1_to_s1 assertion pass");
  end else begin
    $display("p_s1_to_s1 assertion failed");
  end

  assert property (p_s2_to_s3) begin
    $display("p_s2_to_s3 assertion pass");
  end else begin
    $display("p_s2_to_s3 assertion failed");
  end

  assert property (p_s2_to_s0) begin
    $display("p_s2_to_s0 assertion pass");
  end else begin
    $display("p_s2_to_s0 assertion failed");
  end

  assert property (p_s3_to_s4) begin
    $display("p_s3_to_s4 assertion pass");
  end else begin
    $display("p_s3_to_s4 assertion failed");
  end

  assert property (p_s3_to_s2) begin
    $display("p_s3_to_s2 assertion pass");
  end else begin
    $display("p_s3_to_s2 assertion failed");
  end

  assert property (p_s4_to_s1) begin
    $display("p_s4_to_s1 assertion pass");
  end else begin
    $display("p_s4_to_s1 assertion failed");
  end

  assert property (p_s4_to_s2) begin
    $display("p_s4_to_s2 assertion pass");
  end else begin
    $display("p_s4_to_s2 assertion failed");
  end

  assert property (p_pattern_detect) begin
    $display("p_pattern_detect assertion pass");
  end else begin
    $display("p_pattern_detect assertion failed");
  end

  assert property (p_reset) begin
    $display("p_reset assertion pass");
  end else begin
    $display("p_reset assertion failed");
  end

  // Coverage properties
  C1 :
  cover property (p_pattern_detect);
  C2 :
  cover property (p_reset);
  C3 :
  cover property (p_s0_to_s1);
  C4 :
  cover property (p_s0_to_s0);
  C5 :
  cover property (p_s1_to_s2);
  C6 :
  cover property (p_s1_to_s1);
  C7 :
  cover property (p_s2_to_s3);
  C8 :
  cover property (p_s2_to_s0);
  C9 :
  cover property (p_s3_to_s4);
  C10 :
  cover property (p_s3_to_s2);
  C11 :
  cover property (p_s4_to_s1);
  C12 :
  cover property (p_s4_to_s2);




endmodule
