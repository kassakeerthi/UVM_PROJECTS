package test_pkg;

  import uvm_pkg::*;

  `include "uvm_macros.svh"

  `include "write_trans.sv"
  `include "read_trans.sv"

  `include "write_config.sv"
  `include "read_config.sv"

  `include "write_seqs.sv"
  `include "read_seqs.sv"

  `include "write_driver.sv"
  `include "write_monitor.sv"
  `include "write_sequencer.sv"
  `include "write_agent.sv"

  `include "read_driver.sv"
  `include "read_monitor.sv"
  `include "read_sequencer.sv"
  `include "read_agent.sv"

  `include "scoreboard.sv"

  `include "env.sv"

  `include "base_test.sv"

endpackage


