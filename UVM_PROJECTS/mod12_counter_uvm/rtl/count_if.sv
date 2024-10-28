interface count_if (
    input bit clk
);

  logic reset, load, mode;
  logic [3:0] data_in, data_out;

  // Clocking block for write driver

  clocking wr_drv_cb @(posedge clk);

    default input #1 output #1;

    output reset;
    output load;
    output mode;
    output data_in;

  endclocking : wr_drv_cb

  // Clocking block for write monitor

  clocking wr_mon_cb @(posedge clk);

    default input #1 output #1;

    input reset;
    input load;
    input mode;
    input data_in;

  endclocking : wr_mon_cb

  // Clocking block for read monitor

  clocking rd_mon_cb @(posedge clk);

    default input #1 output #1;

    input data_out;

  endclocking : rd_mon_cb


  // Write driver modport
  modport WR_DRV_MP(clocking wr_drv_cb);

  // Write monitor modport
  modport WR_MON_MP(clocking wr_mon_cb);

  // Write driver modport
  modport RD_MON_MP(clocking rd_mon_cb);


endinterface : count_if
