class wr_driver extends uvm_driver #(trans);

  `uvm_component_utils(wr_driver);

  virtual count_if.DRV_MP vif;

  env_config my_config;

  function new(string name = "wr_driver", uvm_component parent);
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

      @(vif.wr_drv_cb);
      vif.wr_drv_cb.load <= req.load;
      vif.wr_drv_cb.mode <= req.mode;
      vif.wr_drv_cb.reset <= req.reset;
      vif.wr_drv_cb.data_in <= req.data_in;

      seq_item_port.item_done();
    end
  endtask

endclass


