class wr_agent extends uvm_env;

  `uvm_component_utils(wr_agent);

  env_config my_config;

  wr_monitor mon_h;
  wr_sequencer seqr_h;
  wr_driver drv_h;


  function new(string name = "wr_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(env_config)::get(this, "", "env_config", my_config)) begin
      `uvm_fatal("WR_AGENT", "Set the env_config")
    end

    mon_h = wr_monitor::type_id::create("mon_h", this);

    if (my_config.is_active == UVM_ACTIVE) begin
      drv_h  = wr_driver::type_id::create("drv_h", this);
      seqr_h = wr_sequencer::type_id::create("seqr_h", this);
    end

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (my_config.is_active == UVM_ACTIVE) begin
      drv_h.seq_item_port.connect(seqr_h.seq_item_export);
    end

  endfunction : connect_phase

endclass
