class read_monitor extends uvm_monitor;

  `uvm_component_utils(read_monitor);

  virtual fifo_rd_if.RD_MON_MP vif;

  read_config my_config;
  read_trans data_sent;

  uvm_analysis_port #(read_trans) read_port;

  function new(string name = "read_monitor", uvm_component parent);
    super.new(name, parent);
    read_port = new("read_port", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("READ_MONITOR", "This is build_phase", UVM_LOW)

    if (!uvm_config_db#(read_config)::get(this, "", "read_config", my_config)) begin
      `uvm_fatal("READ_MONITOR", "Set the read_config")
    end
  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("READ_MONITOR", "This is connect_phase", UVM_LOW)
    vif = my_config.vif;
  endfunction : connect_phase

  virtual task run_phase(uvm_phase phase);
    `uvm_info("READ_MONITOR", "This is run_phase", UVM_LOW)
    // repeat (3) @(vif.rd_mon_cb);
    forever begin
      collect_data();
    end
  endtask : run_phase

  virtual task collect_data();

    `uvm_info("READ_MONITOR", "This is collect_data", UVM_LOW)

    data_sent = read_trans::type_id::create("data_sent");

    wait (vif.rd_mon_cb.read_en);

    @(vif.rd_mon_cb);
    data_sent.read_en = vif.rd_mon_cb.read_en;
    data_sent.data_out = vif.rd_mon_cb.data_out;
    data_sent.empty = vif.rd_mon_cb.empty;

    `uvm_info("READ_MONITOR", $sformatf("printing from monitor \n %s", data_sent.sprint()), UVM_LOW)

    read_port.write(data_sent);

  endtask


endclass
