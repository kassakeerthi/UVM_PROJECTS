package counter_pkg;

  import uvm_pkg::*;

  `include "uvm_macros.svh"

  `include "trans.sv"
  `include "env_config.sv"

  `include "counter_seqs.sv"

  `include "wr_driver.sv"
  `include "wr_monitor.sv"
  `include "wr_sequencer.sv"
  `include "wr_agent.sv"

  `include "rd_monitor.sv"
  `include "rd_agent.sv"

  `include "scoreboard.sv"

  `include "env.sv"

  `include "base_test.sv"

endpackage

