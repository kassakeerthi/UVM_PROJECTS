interface counter_if (
    input bit clk
);

  logic rst_h;
  logic [3:0] out;

  // Driver clocking block
  clocking drv_cb @(posedge clk);
    default input #1 output #1;
    output rst_h;
  endclocking : drv_cb

  // Monitor clocking block
  clocking mon_cb @(posedge clk);
    default input #0 output #1;
    input out;
    input rst_h;
  endclocking : mon_cb

  modport DRV_MP(clocking drv_cb);
  modport MON_MP(clocking mon_cb);

endinterface
