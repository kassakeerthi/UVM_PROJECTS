interface fifo_wr_if (
    input clk
);

  logic reset, write_en;
  logic [7:0] data_in;
  logic full;


  clocking wr_drv_cb @(posedge clk);
    output write_en;
    output data_in;
    output reset;
    input full;
  endclocking : wr_drv_cb

  clocking wr_mon_cb @(posedge clk);
    // default input #0 output #1;
    input write_en;
    input data_in;
    input reset;
    input full;
  endclocking : wr_mon_cb

  modport WR_DRV_MP(clocking wr_drv_cb);
  modport WR_MON_MP(clocking wr_mon_cb);

endinterface
