module top ();

  import counter_pkg::*;
  import uvm_pkg::*;

  bit clk;

  initial begin
    clk = 1'b0;
    forever begin
      #5 clk = ~clk;
    end
  end

  counter_if in (clk);

  counter duv (
      .clk  (clk),
      .rst_h(in.rst_h),
      .out  (in.out)
  );

  initial begin

    uvm_config_db#(virtual counter_if)::set(null, "*", "vif", in);

    run_test();

  end

  property pp1;
    @(posedge clk) (in.rst_h) |=> (in.out == 0);
  endproperty

  property pp2;
    @(posedge clk) $fell(
        in.rst_h
    ) |=> in.out + 1'b1;
  endproperty

  assert property (pp1) begin
    $display("reset assertion pass");
  end else begin
    $display("reset assertion fail");
  end

  assert property (pp2) begin
    $display("reset_low assertion pass");
  end else begin
    $display("reset_low assertion fail");
  end

  C1 :
  cover property (pp1);
  C2 :
  cover property (pp2);

endmodule
