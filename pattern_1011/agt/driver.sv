class driver extends uvm_driver #(trans);

  `uvm_component_utils(driver);

  virtual fsm_if.DRV_MP vif;

  env_config my_config;

  function new(string name = "driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(env_config)::get(this, "", "env_config", my_config)) begin
      `uvm_fatal("DRIVER", "Set the env_config properly")
    end

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = my_config.vif;
  endfunction : connect_phase

  task run_phase(uvm_phase phase);

    forever begin

      seq_item_port.get_next_item(req);

      `uvm_info("DRIVER", $sformatf("printing from driver \n %s", req.sprint()), UVM_LOW)

      @(vif.drv_cb);
      vif.drv_cb.reset <= req.reset;
      vif.drv_cb.in <= req.in;

      seq_item_port.item_done();

    end

  endtask : run_phase

endclass





