class read_agent extends uvm_agent;

  `uvm_component_utils(read_agent);

  read_monitor mon_h;
  read_driver drv_h;
  read_sequencer seqr_h;

  read_config my_config;

  function new(string name = "read_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info("READ_AGENT", "This is build_phase", UVM_LOW)

    if (!uvm_config_db#(read_config)::get(this, "", "read_config", my_config)) begin
      `uvm_fatal("READ_AGENT", "Set the read_config")
    end

    mon_h = read_monitor::type_id::create("mon_h", this);

    if (my_config.is_active == UVM_ACTIVE) begin
      drv_h  = read_driver::type_id::create("drv_h", this);
      seqr_h = read_sequencer::type_id::create("seqr_h", this);
    end

  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("READ_AGENT", "This is connect_phase", UVM_LOW)
    if (my_config.is_active == UVM_ACTIVE) begin
      drv_h.seq_item_port.connect(seqr_h.seq_item_export);
    end
  endfunction : connect_phase


endclass

