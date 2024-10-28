class env extends uvm_env;

  `uvm_component_utils(env);

  write_agent wr_agt_h;
  read_agent  rd_agt_h;

  scoreboard  sb_h;

  function new(string name = "env", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    `uvm_info("ENV", "This is build_phase", UVM_LOW)

    wr_agt_h = write_agent::type_id::create("wr_agt_h", this);
    rd_agt_h = read_agent::type_id::create("rd_agt_h", this);

    sb_h = scoreboard::type_id::create("sb_h", this);

  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    `uvm_info("ENV", "This is connect_phase", UVM_LOW)

    wr_agt_h.mon_h.write_port.connect(sb_h.write_fifo.analysis_export);
    rd_agt_h.mon_h.read_port.connect(sb_h.read_fifo.analysis_export);

  endfunction : connect_phase

endclass
