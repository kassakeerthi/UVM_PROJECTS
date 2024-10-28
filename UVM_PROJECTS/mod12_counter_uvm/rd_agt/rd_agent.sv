class rd_agent extends uvm_env;

  `uvm_component_utils(rd_agent);

  env_config my_config;

  rd_monitor mon_h;

  function new(string name = "rd_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    mon_h = rd_monitor::type_id::create("mon_h", this);

  endfunction : build_phase

endclass
