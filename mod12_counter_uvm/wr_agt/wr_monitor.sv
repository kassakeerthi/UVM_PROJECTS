class wr_monitor extends uvm_monitor;

  `uvm_component_utils(wr_monitor);

  virtual count_if.WR_MON_MP vif;
  env_config my_config;

  uvm_analysis_port #(trans) wr_mon_port;

  function new(string name = "wr_monitor", uvm_component parent);
    super.new(name, parent);
    wr_mon_port = new("wr_mon_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(env_config)::get(this, "", "env_config", my_config)) begin
      `uvm_fatal("WR_MONITOR", "Set the env_config")
    end

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = my_config.vif;
  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    @(vif.wr_mon_cb);
    forever begin
      collect_data();
    end
  endtask : run_phase

  task collect_data();
    trans pkt;
    pkt = trans::type_id::create("pkt");
    @(vif.wr_mon_cb);
    pkt.load = vif.wr_mon_cb.load;
    pkt.mode = vif.wr_mon_cb.mode;
    pkt.reset = vif.wr_mon_cb.reset;
    pkt.data_in = vif.wr_mon_cb.data_in;

    `uvm_info("WR_MONITOR", $sformatf("printing from write_monitor \n %s", pkt.sprint()), UVM_LOW)

    wr_mon_port.write(pkt);
  endtask
endclass


