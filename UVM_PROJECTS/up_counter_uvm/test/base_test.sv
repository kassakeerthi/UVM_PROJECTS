class base_test extends uvm_test;

  `uvm_component_utils(base_test);

  env env_h;
  env_config my_config;

  counter_seqs seqs_h;
  reset_seqs r_seqs_h;

  function new(string name = "base_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    my_config = env_config::type_id::create("my_config");

    if (!uvm_config_db#(virtual counter_if)::get(this, "", "vif", my_config.vif)) begin
      `uvm_fatal("base_test", "Set the vif")
    end

    my_config.is_active = UVM_ACTIVE;

    uvm_config_db#(env_config)::set(this, "*", "env_config", my_config);

    env_h = env::type_id::create("env_h", this);

  endfunction : build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    phase.raise_objection(this);

    r_seqs_h = reset_seqs::type_id::create("r_seqs_h");
    r_seqs_h.start(env_h.agt_h.seqr_h);
    repeat (5) begin
      seqs_h = counter_seqs::type_id::create("seqs_h");
      seqs_h.start(env_h.agt_h.seqr_h);
    end

    phase.drop_objection(this);

  endtask : run_phase

endclass

