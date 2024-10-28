module top;
  import uvm_pkg::*;
  import counter_pkg::*;

  bit clk;

  initial begin
    clk = 1'b0;
    forever begin
      #5 clk = ~clk;
    end
  end

  count_if dut_if (clk);

  counter dut (
      .clk(clk),
      .load(dut_if.load),
      .mode(dut_if.mode),
      .reset(dut_if.reset),
      .data_in(dut_if.data_in),
      .data_out(dut_if.data_out)
  );


  initial begin
    uvm_config_db#(virtual count_if)::set(null, "*", "vif", dut_if);
    run_test();
  end


  // Reset assertion
  property reset_p;
    @(posedge clk) dut_if.reset |=> (dut_if.data_out == 4'd0);
  endproperty

  // Load assertion
  property load_p;
    @(posedge clk) (dut_if.load && !dut_if.reset) |=> (dut_if.data_out == $past(
        dut_if.data_in
    ));
  endproperty

  // Count up assertion
  property count_up_p;
    @(posedge clk) (dut_if.mode && !dut_if.reset && !dut_if.load && (dut_if.data_out != 4'd11)) |=> (dut_if.data_out == $past(
        dut_if.data_out
    ) + 4'd1);
  endproperty

  // Count down assertion
  property count_down_p;
    @(posedge clk) (!dut_if.mode && !dut_if.reset && !dut_if.load && (dut_if.data_out != 4'd0)) |=> (dut_if.data_out == $past(
        dut_if.data_out
    ) - 4'd1);
  endproperty

  // Wrap around up assertion
  property wrap_around_up_p;
    @(posedge clk) (dut_if.mode && !dut_if.reset && !dut_if.load && (dut_if.data_out == 4'd11)) |=> (dut_if.data_out == 4'd0);
  endproperty

  // Wrap around down assertion
  property wrap_around_down_p;
    @(posedge clk) (!dut_if.mode && !dut_if.reset && !dut_if.load && (dut_if.data_out == 4'd0)) |=> (dut_if.data_out == 4'd11);
  endproperty


  assert property (reset_p) begin
    $display("Reset assertion pass");
  end else begin
    $error("Reset assertion failed");
  end

  assert property (load_p) begin
    $display("Load assertion pass");
  end else begin
    $error("Load assertion failed");
  end

  assert property (count_up_p) begin
    $display("Count up assertion pass");
  end else begin
    $error("Count up assertion failed");
  end

  assert property (count_down_p) begin
    $display("Count down assertion pass");
  end else begin
    $error("Count down assertion failed");
  end

  assert property (wrap_around_up_p) begin
    $display("Wrap around up assertion pass");
  end else begin
    $error("Wrap around up assertion failed");
  end

  assert property (wrap_around_down_p) begin
    $display("Wrap around down assertion pass");
  end else begin
    $error("Wrap around down assertion failed");
  end

  C1 :
  cover property (reset_p);

  C2 :
  cover property (load_p);

  C3 :
  cover property (count_up_p);

  C4 :
  cover property (count_down_p);

  C5 :
  cover property (wrap_around_up_p);

  C6 :
  cover property (wrap_around_down_p);


endmodule


