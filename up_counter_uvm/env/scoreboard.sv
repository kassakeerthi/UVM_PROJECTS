class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard);

  uvm_tlm_analysis_fifo #(trans) mon_fifo;

  trans mon_pkt;
  trans rd_cov_pkt;
  trans wr_cov_pkt;

  bit [3:0] out;

  covergroup counter_cg;

    RST: coverpoint cov_pkt.rst_h;

    OUT: coverpoint cov_pkt.out {

      bins ZERO = {0};
      bins LOW1 = {[1 : 2]};
      bins LOW2 = {[3 : 4]};
      bins MID_LOW = {[5 : 6]};
      bins MID = {[7 : 8]};
      bins MID_HIGH = {[9 : 10]};
      bins HIGH1 = {[11 : 12]};
      bins HIGH2 = {[13 : 14]};
      bins MAX = {15};

    }

  endgroup

  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    mon_fifo   = new("mon_fifo", this);
    counter_cg = new();
    // cov_pkt  = new("cov_pkt");
  endfunction

  task run_phase(uvm_phase phase);

    forever begin
      mon_fifo.get(mon_pkt);
      cov_pkt = mon_pkt;
      counter_cg.sample();
      `uvm_info("SCOREBOARD", $sformatf("printing from scoreboard \n %s", mon_pkt.sprint()),
                UVM_LOW)
      ref_model();
      validate_output();
    end

  endtask : run_phase

  task ref_model();

    if (mon_pkt.rst_h) begin
      out = 0;
    end else begin
      out = out + 1;
    end

    `uvm_info("REF_MODEL", $sformatf("out = %0d", out), UVM_LOW)

  endtask : ref_model

  task validate_output();

    if (mon_pkt.out == out) begin
      $display("Comparison pass");
    end else begin
      $display("Comparison failed");
    end

  endtask : validate_output

endclass
