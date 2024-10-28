class read_driver extends uvm_driver #(read_trans);

  `uvm_component_utils(read_driver);

  virtual fifo_rd_if.RD_DRV_MP vif;

  read_config my_config;

  function new(string name = "read_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info("READ_DRIVER", "This is build_phase", UVM_LOW)

    if (!uvm_config_db#(read_config)::get(this, "", "read_config", my_config)) begin
      `uvm_fatal("READ_DRIVER", "Set the read_config")
    end

  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("READ_DRIVER", "This is connect_phase", UVM_LOW)
    vif = my_config.vif;
  endfunction : connect_phase

  virtual task run_phase(uvm_phase phase);

    `uvm_info("READ_DRIVER", "This is run_phase", UVM_LOW)

    forever begin
      seq_item_port.get_next_item(req);
      send_to_dut(req);
      seq_item_port.item_done();
    end

    // vif.rd_drv_cb.read_en <= 0;

  endtask : run_phase

  task send_to_dut(read_trans trans);

    `uvm_info("READ_DRIVER", "This is send_to_dut", UVM_LOW)

    // wait (vif.rd_drv_cb.empty == 0);

    if (!vif.rd_drv_cb.empty) begin
      @(vif.rd_drv_cb);
      vif.rd_drv_cb.read_en <= trans.read_en;
    end else begin
      `uvm_info("READ_DRIVER", "Fifo if empty we cant read", UVM_LOW)
    end

    `uvm_info("READ_DRIVER", $sformatf("Printing from Read moniotr \n %s", trans.sprint()), UVM_LOW)



  endtask

endclass
