class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard);

  trans wr_pkt;
  trans rd_pkt;

  trans ref_pkt;

  trans rd_cov_pkt;
  trans wr_cov_pkt;

  int wr_data_count = 0;
  int rd_data_count = 0;

  int comp_pass = 0;
  int comp_fail = 0;

  uvm_tlm_analysis_fifo #(trans) rd_mon_fifo;
  uvm_tlm_analysis_fifo #(trans) wr_mon_fifo;

  bit [3:0] data_out;

  covergroup wr_counter_cg;

    RST: coverpoint wr_cov_pkt.reset;
    MODE: coverpoint wr_cov_pkt.mode;
    LOAD: coverpoint wr_cov_pkt.load;

    DATA_IN: coverpoint wr_cov_pkt.data_in {

      bins LOW1 = {[1 : 2]};
      bins MID_LOW = {[3 : 4]};
      bins MID = {[5 : 6]};
      bins MID_HIGH = {[7 : 8]};
      bins HIGH = {9};
      bins MAX = {10};

    }


  endgroup

  covergroup rd_counter_cg;

    DATA_OUT: coverpoint rd_cov_pkt.data_out {

      bins ZERO = {0};
      bins LOW = {[1 : 2]};
      bins MID_LOW = {[3 : 4]};
      bins MID = {[5 : 6]};
      bins MID_HIGH = {[7 : 8]};
      bins HIGH = {[9 : 10]};
      bins MAX = {11};

    }

  endgroup


  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);

    rd_mon_fifo = new("rd_mon_fifo", this);
    wr_mon_fifo = new("wr_mon_fifo", this);

    wr_counter_cg = new();
    rd_counter_cg = new();

    ref_pkt = trans::type_id::create("ref_pkt");

  endfunction

  task run_phase(uvm_phase phase);

    forever begin

      begin
        wr_mon_fifo.get(wr_pkt);
        wr_pkt.print();
        wr_cov_pkt = wr_pkt;
        wr_counter_cg.sample();
        wr_data_count++;
      end

      begin
        rd_mon_fifo.get(rd_pkt);
        rd_pkt.print();
        rd_cov_pkt = rd_pkt;
        rd_counter_cg.sample();
        rd_data_count++;
      end

      count_ref();

      // compare();
      validate_output();

    end

  endtask : run_phase

  // task count_ref(trans wrmon_data);
  //
  //   `uvm_info("REF_MODEL", "This is ref_model", UVM_LOW)
  //
  //   if (wrmon_data.reset) begin
  //     data_out = 4'd0;
  //   end else if (wrmon_data.load) begin
  //     data_out = wrmon_data.data_in;
  //   end else begin
  //     if (wrmon_data.mode) begin
  //       if (data_out == 4'd11) begin
  //         data_out = 4'd0;
  //       end else begin
  //         data_out = data_out + 4'd1;
  //       end
  //     end else begin
  //       if (data_out == 0) begin
  //         data_out = 4'd11;
  //       end else begin
  //         data_out = data_out - 4'd1;
  //       end
  //     end
  //   end
  //
  //   `uvm_info("REF_MODEL", $sformatf("data_out = %0d", data_out), UVM_LOW)
  //
  // endtask : count_ref

  // task compare();
  //
  //   if (rd_pkt.data_out == data_out) begin
  //     $display("comparison pass");
  //     comp_pass++;
  //   end else begin
  //     $display("comparison failed");
  //     comp_fail++;
  //   end
  //
  // endtask


  task count_ref();
    if (wr_pkt.reset || (wr_pkt.load & wr_pkt.data_in >= 11)) begin
      ref_pkt.data_out = 4'b0;
    end else if (wr_pkt.load) begin
      ref_pkt.data_out = wr_pkt.data_in;
    end else begin
      if (wr_pkt.mode) begin  // Mode = 1
        if (wr_pkt.data_in >= 4'd11) begin
          ref_pkt.data_out = 0;
        end else begin
          ref_pkt.data_out = ref_pkt.data_out + 1;
        end
      end else begin  // Mode = 0
        if (wr_pkt.data_in <= 0) begin
          ref_pkt.data_out = 4'd11;
        end else begin
          ref_pkt.data_out = ref_pkt.data_out - 1;
        end
      end
    end
  endtask

  task validate_output();

    if (!ref_pkt.compare(rd_pkt)) begin
      `uvm_info("SCOREBOARD", $sformatf("ref_pkt is below \n%s", ref_pkt.sprint()), UVM_LOW)
      `uvm_info("SCOREBOARD", $sformatf("rd_pkt is below \n%s", rd_pkt.sprint()), UVM_LOW)
    end else begin
      `uvm_info("SCOREBOARD", $sformatf("Data is matched  \n%s", rd_pkt.sprint()), UVM_LOW)
    end

  endtask


endclass
