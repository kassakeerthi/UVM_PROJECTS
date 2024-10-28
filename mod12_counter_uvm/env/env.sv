class env extends uvm_env;

  `uvm_component_utils(env);

  wr_agent   wr_agt_h;
  rd_agent   rd_agt_h;
  scoreboard sb_h;

  function new(string name = "env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wr_agt_h = wr_agent::type_id::create("wr_agt_h", this);
    rd_agt_h = rd_agent::type_id::create("rd_agt_h", this);
    sb_h = scoreboard::type_id::create("sb_h", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    uvm_top.print_topology();

    wr_agt_h.mon_h.wr_mon_port.connect(sb_h.wr_mon_fifo.analysis_export);
    rd_agt_h.mon_h.rd_mon_port.connect(sb_h.rd_mon_fifo.analysis_export);

  endfunction : connect_phase

endclass
