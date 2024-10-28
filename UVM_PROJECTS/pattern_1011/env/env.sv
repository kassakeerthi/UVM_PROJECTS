class env extends uvm_env;

  `uvm_component_utils(env);

  agent agt_h;
  scoreboard sb_h;

  env_config my_config;

  function new(string name = "env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt_h = agent::type_id::create("agt_h", this);
    sb_h  = scoreboard::type_id::create("sb_h", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    uvm_top.print_topology();

    agt_h.mon_h.mon_port.connect(sb_h.mon_fifo.analysis_export);

  endfunction : connect_phase

endclass
