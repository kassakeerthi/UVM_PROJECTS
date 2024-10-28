class read_config extends uvm_object;

  `uvm_object_utils(read_config);

  virtual fifo_rd_if vif;

  uvm_active_passive_enum is_active = UVM_ACTIVE;

  function new(string name = "read_config");
    super.new(name);
  endfunction

endclass
