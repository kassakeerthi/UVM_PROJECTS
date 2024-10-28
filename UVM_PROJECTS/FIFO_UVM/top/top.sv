module top ();

  bit clk;

  import test_pkg::*;
  import uvm_pkg::*;

  fifo_wr_if wr_if (clk);
  fifo_rd_if rd_if (clk);

  fifo duv (

      .clk(clk),

      // write interface
      .reset(wr_if.reset),
      .write_en(wr_if.write_en),
      .data_in(wr_if.data_in),
      .full(wr_if.full),

      // read interface
      .read_en(rd_if.read_en),
      .data_out(rd_if.data_out),
      .empty(rd_if.empty)

  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin

    uvm_config_db#(virtual fifo_wr_if)::set(null, "*", "wr_if", wr_if);
    uvm_config_db#(virtual fifo_rd_if)::set(null, "*", "rd_if", rd_if);

    run_test();

  end


endmodule
