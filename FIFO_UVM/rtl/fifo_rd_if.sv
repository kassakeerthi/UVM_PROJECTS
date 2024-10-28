interface fifo_rd_if (
    input clk
);

  logic [7:0] data_out;
  logic read_en, empty;

  clocking rd_drv_cb @(posedge clk);
    output read_en;
    input empty;
  endclocking : rd_drv_cb

  clocking rd_mon_cb @(posedge clk);
    input read_en;
    input empty;
    input data_out;
  endclocking : rd_mon_cb

  modport RD_DRV_MP(clocking rd_drv_cb);
  modport RD_MON_MP(clocking rd_mon_cb);

endinterface
