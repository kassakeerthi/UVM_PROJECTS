class write_config extends uvm_object;

  `uvm_object_utils(write_config);

  virtual fifo_wr_if vif;

  uvm_active_passive_enum is_active = UVM_ACTIVE;

  function new(string name = "write_config");
    super.new(name);
  endfunction

endclass
