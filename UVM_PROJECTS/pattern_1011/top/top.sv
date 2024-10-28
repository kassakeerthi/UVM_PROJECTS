`define LENGTH 4

module top ();

  import fsm_pkg::*;
  import uvm_pkg::*;

  bit clk;

  initial begin
    clk = 1'b0;
    forever begin
      #5 clk = ~clk;
    end
  end

  // fsm_if inf (clk);
  fsm_if intf (clk);

  counter duv (
      .clk(clk),
      .reset(intf.reset),
      .in(intf.in),
      .out(intf.out)
  );

  initial begin

    uvm_config_db#(virtual fsm_if)::set(null, "*", "vif", intf);

    run_test();

  end

endmodule
