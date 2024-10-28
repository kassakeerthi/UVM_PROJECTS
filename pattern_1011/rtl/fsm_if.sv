interface fsm_if (
    input clk
);

  logic reset;
  logic in;
  logic out;

  clocking drv_cb @(posedge clk);
    output reset;
    output in;
  endclocking : drv_cb

  clocking mon_cb @(posedge clk);
    input out;
    input reset;
    input in;
  endclocking : mon_cb

  modport DRV_MP(clocking drv_cb);
  modport MON_MP(clocking mon_cb);

endinterface

