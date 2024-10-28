class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard);

  uvm_tlm_analysis_fifo #(trans) mon_fifo;

  env_config my_config;

  trans mon_pkt;
  trans cov_pkt;

  bit [3 : 0] current_pattern;
  bit [4 : 0] output_pattern;  // For coverage
  bit [3 : 0] ref_pattern;

  covergroup fsm_cg;

    RST: coverpoint cov_pkt.reset;

    INPUT: coverpoint cov_pkt.in;

    INPUT_SEQS: coverpoint current_pattern {

      bins pattern_1011 = {4'b1011};
      bins partial_101 = {4'b1010};
      bins partial_10 = {4'b1000, 4'b1001};
      bins after_reset = {4'b0000};
      bins others = default;

    }

    OUTPUT_SEQ: coverpoint output_pattern {
      // Single detection
      bins single_detect = {5'b00001};
      // Multiple detections
      bins overlapping_detect = {5'b01001, 5'b10001};
      // No detection
      bins no_detect = {5'b00000};
      // Other sequences
      bins others = default;
    }


    OUTPUT: coverpoint cov_pkt.out;

  endgroup

  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    mon_fifo = new("mon_fifo", this);
    fsm_cg   = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(env_config)::get(this, "", "env_config", my_config)) begin
      `uvm_fatal("SCOREBOARD", "Set the env_config")
    end
    ref_pattern = my_config.ref_pattern;

  endfunction : build_phase

  task run_phase(uvm_phase phase);

    forever begin
      mon_fifo.get(mon_pkt);
      cov_pkt = mon_pkt;
      fsm_cg.sample();
      `uvm_info("SCOREBOARD", $sformatf("printing from scoreboard \n %s", mon_pkt.sprint()),
                UVM_LOW)
      ref_model();
      validate_output();
    end

  endtask : run_phase

  task ref_model();

    if (mon_pkt.reset) begin
      current_pattern = 0;
    end else begin
      current_pattern = {current_pattern[2:0], mon_pkt.in};
      output_pattern  = {output_pattern[3:0], mon_pkt.out};  // For coverage only
    end

  endtask : ref_model


  task validate_output();

    if (current_pattern == ref_pattern) begin
      $display("pattern matched next out should be 1");
    end else begin
      $display("pattern not matched");
    end

  endtask : validate_output

endclass
