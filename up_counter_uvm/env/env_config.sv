class env_config extends uvm_object;

  `uvm_object_utils(env_config);

  virtual counter_if vif;

  uvm_active_passive_enum is_active = UVM_ACTIVE;

  function new(string name = "env_config");
    super.new(name);
  endfunction

endclass

