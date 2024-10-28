class monitor extends uvm_monitor;

  `uvm_component_utils(monitor);

  virtual counter_if.MON_MP vif;
  env_config my_config;

  trans pkt;

  uvm_analysis_port #(trans) mon_port;

  function new(string name = "monitor", uvm_component parent);
    super.new(name, parent);
    mon_port = new("mon_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(env_config)::get(this, "", "env_config", my_config)) begin
      `uvm_fatal("MONITOR", "Set the env_config")
    end

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = my_config.vif;
  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    @(vif.mon_cb);
    forever begin
      collect_data();
    end
  endtask : run_phase

  task collect_data();
    pkt = trans::type_id::create("pkt");

    @(vif.mon_cb);
    pkt.out   = vif.mon_cb.out;
    pkt.rst_h = vif.mon_cb.rst_h;

    `uvm_info("MONITOR", $sformatf("printing from monitor \n %s", pkt.sprint()), UVM_LOW)

    mon_port.write(pkt);

  endtask


endclass
