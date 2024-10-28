class base_test extends uvm_test;

  `uvm_component_utils(base_test);

  env env_h;

  write_config w_cfg;
  read_config r_cfg;

  write_seqs wr_seqs_h;
  low_read_seqs rd_seqs_h;

  int no_of_cycle = 10;


  function new(string name = "base_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // For write config

    w_cfg = write_config::type_id::create("w_cfg");

    if (!uvm_config_db#(virtual fifo_wr_if)::get(this, "", "wr_if", w_cfg.vif)) begin
      `uvm_fatal("BASE_TEST", "Set the write interface")
    end

    w_cfg.is_active = UVM_ACTIVE;

    uvm_config_db#(write_config)::set(this, "*", "write_config", w_cfg);

    // For read_config

    r_cfg = read_config::type_id::create("r_cfg");

    if (!uvm_config_db#(virtual fifo_rd_if)::get(this, "", "rd_if", r_cfg.vif)) begin
      `uvm_fatal("BASE_TEST", "Set the read interface")
    end

    r_cfg.is_active = UVM_ACTIVE;

    uvm_config_db#(read_config)::set(this, "*", "read_config", r_cfg);

    env_h = env::type_id::create("env_h", this);

  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);

    phase.raise_objection(this);


    wr_seqs_h = write_seqs::type_id::create("wr_seqs_h");
    rd_seqs_h = low_read_seqs::type_id::create("rd_seqs_h");

    $display("start of write");
    wr_seqs_h.start(env_h.wr_agt_h.seqr_h);
    $display("end of write");

    $display("start of read");
    rd_seqs_h.start(env_h.rd_agt_h.seqr_h);
    $display("end of read");

    phase.drop_objection(this);

  endtask : run_phase

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction : end_of_elaboration_phase

endclass

/* ----------------------------------------------------------------------*/

class low_test extends base_test;

  `uvm_component_utils(low_test)

  low_seqs  wr_seqs_h;
  read_seqs rd_seqs_h;

  function new(string name = "low_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info("LOW_TEST", "This is build_phase", UVM_LOW)
    super.build_phase(phase);
  endfunction : build_phase


  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    `uvm_info("LOW_TEST", "This is run_phase", UVM_LOW)

    wr_seqs_h = low_seqs::type_id::create("wr_seqs_h");
    rd_seqs_h = read_seqs::type_id::create("rd_seqs_h");

    $display("start of write");
    wr_seqs_h.start(env_h.wr_agt_h.seqr_h);
    $display("end of write");

    $display("start of read");
    rd_seqs_h.start(env_h.rd_agt_h.seqr_h);
    $display("end of read");

    phase.drop_objection(this);

  endtask : run_phase

endclass

/* ----------------------------------------------------------------------*/

class medium_test extends base_test;

  `uvm_component_utils(medium_test)

  medium_seqs wr_seqs_h;
  read_seqs   rd_seqs_h;

  function new(string name = "medium_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info("MEDIUM_TEST", "This is build_phase", UVM_LOW)
    super.build_phase(phase);
  endfunction : build_phase


  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    `uvm_info("MEDIUM_TEST", "This is run_phase", UVM_LOW)

    wr_seqs_h = medium_seqs::type_id::create("wr_seqs_h");
    rd_seqs_h = read_seqs::type_id::create("rd_seqs_h");

    $display("start of write");
    wr_seqs_h.start(env_h.wr_agt_h.seqr_h);
    $display("end of write");

    $display("start of read");
    rd_seqs_h.start(env_h.rd_agt_h.seqr_h);
    $display("end of read");

    phase.drop_objection(this);

  endtask : run_phase

endclass

/* ----------------------------------------------------------------------*/

class large_test extends base_test;

  `uvm_component_utils(large_test)

  large_seqs wr_seqs_h;
  read_seqs  rd_seqs_h;

  function new(string name = "large_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info("LARGE_TEST", "This is build_phase", UVM_LOW)
    super.build_phase(phase);
  endfunction : build_phase


  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    `uvm_info("LARGE_TEST", "This is run_phase", UVM_LOW)

    wr_seqs_h = large_seqs::type_id::create("wr_seqs_h");
    rd_seqs_h = read_seqs::type_id::create("rd_seqs_h");

    $display("start of write");
    wr_seqs_h.start(env_h.wr_agt_h.seqr_h);
    $display("end of write");

    $display("start of read");
    rd_seqs_h.start(env_h.rd_agt_h.seqr_h);
    $display("end of read");

    phase.drop_objection(this);

  endtask : run_phase

endclass

/* ----------------------------------------------------------------------*/

class zero_test extends base_test;

  `uvm_component_utils(zero_test)

  zero_seqs wr_seqs_h;
  read_seqs rd_seqs_h;

  function new(string name = "zero_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info("zero_TEST", "This is build_phase", UVM_LOW)
    super.build_phase(phase);
  endfunction : build_phase


  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    `uvm_info("zero_TEST", "This is run_phase", UVM_LOW)

    wr_seqs_h = zero_seqs::type_id::create("wr_seqs_h");
    rd_seqs_h = read_seqs::type_id::create("rd_seqs_h");

    $display("start of write");
    wr_seqs_h.start(env_h.wr_agt_h.seqr_h);
    $display("end of write");

    $display("start of read");
    rd_seqs_h.start(env_h.rd_agt_h.seqr_h);
    $display("end of read");

    phase.drop_objection(this);

  endtask : run_phase

endclass

/* ----------------------------------------------------------------------*/

class max_test extends base_test;

  `uvm_component_utils(max_test)

  max_seqs  wr_seqs_h;
  read_seqs rd_seqs_h;

  function new(string name = "max_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info("max_TEST", "This is build_phase", UVM_LOW)
    super.build_phase(phase);
  endfunction : build_phase


  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    `uvm_info("max_TEST", "This is run_phase", UVM_LOW)

    wr_seqs_h = max_seqs::type_id::create("wr_seqs_h");
    rd_seqs_h = read_seqs::type_id::create("rd_seqs_h");

    $display("start of write");
    wr_seqs_h.start(env_h.wr_agt_h.seqr_h);
    $display("end of write");

    $display("start of read");
    rd_seqs_h.start(env_h.rd_agt_h.seqr_h);
    $display("end of read");

    phase.drop_objection(this);

  endtask : run_phase

endclass

/* ----------------------------------------------------------------------*/

class full_test extends base_test;

  `uvm_component_utils(full_test)

  full_seqs wr_seqs_h;
  read_seqs rd_seqs_h;

  function new(string name = "full_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info("FULL_TEST", "This is build_phase", UVM_LOW)
    super.build_phase(phase);
  endfunction : build_phase


  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    `uvm_info("FULL_TEST", "This is run_phase", UVM_LOW)

    wr_seqs_h = full_seqs::type_id::create("wr_seqs_h");
    rd_seqs_h = read_seqs::type_id::create("rd_seqs_h");

    $display("start of write");
    wr_seqs_h.start(env_h.wr_agt_h.seqr_h);
    $display("end of write");

    $display("start of read");
    rd_seqs_h.start(env_h.rd_agt_h.seqr_h);
    $display("end of read");

    phase.drop_objection(this);

  endtask : run_phase

endclass

/* ----------------------------------------------------------------------*/

class reset_test extends base_test;

  `uvm_component_utils(reset_test)

  reset_seqs wr_seqs_h;
  read_seqs  rd_seqs_h;

  function new(string name = "reset_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info("RESET_TEST", "This is build_phase", UVM_LOW)
    super.build_phase(phase);
  endfunction : build_phase


  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    `uvm_info("RESET_TEST", "This is run_phase", UVM_LOW)

    wr_seqs_h = reset_seqs::type_id::create("wr_seqs_h");
    rd_seqs_h = read_seqs::type_id::create("rd_seqs_h");

    $display("start of write");
    wr_seqs_h.start(env_h.wr_agt_h.seqr_h);
    $display("end of write");

    $display("start of read");
    rd_seqs_h.start(env_h.rd_agt_h.seqr_h);
    $display("end of read");

    phase.drop_objection(this);

  endtask : run_phase

endclass

/* ----------------------------------------------------------------------*/

