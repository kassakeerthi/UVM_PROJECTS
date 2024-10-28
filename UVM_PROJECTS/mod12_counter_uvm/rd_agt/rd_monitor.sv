class rd_monitor extends uvm_monitor;

  `uvm_component_utils(rd_monitor);

  virtual count_if.RD_MON_MP vif;
  env_config my_config;

  uvm_analysis_port #(trans) rd_mon_port;

  function new(string name = "rd_monitor", uvm_component parent);
    super.new(name, parent);
    rd_mon_port = new("rd_mon_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(env_config)::get(this, "", "env_config", my_config)) begin
      `uvm_fatal("rd_monitor", "Set the env_config")
    end

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = my_config.vif;
  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    @(vif.rd_mon_cb);
    forever begin
      collect_data();
    end
  endtask : run_phase

  task collect_data();
    trans pkt;
    pkt = trans::type_id::create("pkt");
    @(vif.rd_mon_cb);
    pkt.data_out = vif.rd_mon_cb.data_out;

    `uvm_info("RD_MONITOR", $sformatf("printing from rd_monitor \n %s", pkt.sprint()), UVM_LOW)

    rd_mon_port.write(pkt);
  endtask
endclass


