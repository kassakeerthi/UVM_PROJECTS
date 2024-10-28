class write_agent extends uvm_agent;

  `uvm_component_utils(write_agent);

  write_monitor mon_h;
  write_driver drv_h;
  write_sequencer seqr_h;

  write_config my_config;

  function new(string name = "write_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(write_config)::get(this, "", "write_config", my_config)) begin
      `uvm_fatal("WRITE_AGENT", "Set the write_config")
    end

    mon_h = write_monitor::type_id::create("mon_h", this);

    if (my_config.is_active == UVM_ACTIVE) begin
      drv_h  = write_driver::type_id::create("drv_h", this);
      seqr_h = write_sequencer::type_id::create("seqr_h", this);
    end

  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (my_config.is_active == UVM_ACTIVE) begin
      drv_h.seq_item_port.connect(seqr_h.seq_item_export);
    end
  endfunction : connect_phase


endclass

