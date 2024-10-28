class scoreboard extends uvm_component;
  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo #(write_trans) write_fifo;
  uvm_tlm_analysis_fifo #(read_trans) read_fifo;

  write_trans write_data;
  read_trans read_data;

  write_trans write_cov;
  read_trans read_cov;

  bit [7:0] mem[$];
  bit [7:0] ref_data;

  int data_written;
  int data_read;
  int no_of_pass;
  int no_of_fail;


  covergroup write_cg;

    RST: coverpoint write_cov.reset;

    WRITE_EN: coverpoint write_cov.write_en;

    FULL: coverpoint write_cov.full;

    DATA_IN: coverpoint write_cov.data_in {

      bins ZERO = {0};
      bins LOW = {[1 : 85]};
      bins MID = {[86 : 170]};
      bins HIGH = {[171 : 254]};
      bins MAX = {255};

    }

  endgroup

  covergroup read_cg;

    READ_EN: coverpoint read_cov.read_en;

    EMPTY: coverpoint read_cov.empty;

    DATA_OUT: coverpoint read_cov.data_out {

      bins ZERO = {0};
      bins LOW = {[1 : 85]};
      bins MID = {[86 : 170]};
      bins HIGH = {[171 : 254]};
      bins MAX = {255};

    }

  endgroup



  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    write_fifo = new("write_fifo", this);
    read_fifo = new("read_fifo", this);
    write_cg = new();
    read_cg = new();
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("SCOREBOARD", "This is run_phase", UVM_LOW)
    fork
      process_writes();
      process_reads();
    join_none
  endtask : run_phase

  // Separate task for processing writes
  task process_writes();
    forever begin
      write_fifo.get(write_data);
      `uvm_info("SCOREBOARD", $sformatf("Got write transaction:\n%s", write_data.sprint()), UVM_LOW)

      write_cov = write_data;
      write_cg.sample();

      if (write_data.reset) begin
        mem.delete();
        `uvm_info("SCOREBOARD", "Memory cleared on reset", UVM_LOW)
      end else if (write_data.write_en && !write_data.full) begin
        mem.push_front(write_data.data_in);
        data_written++;
        `uvm_info("SCOREBOARD", $sformatf("Written data: %0d, FIFO depth: %0d", write_data.data_in,
                                          mem.size()), UVM_LOW)
      end
    end
  endtask

  // Separate task for processing reads
  task process_reads();
    forever begin
      read_fifo.get(read_data);
      `uvm_info("SCOREBOARD", $sformatf("Got read transaction:\n%s", read_data.sprint()), UVM_LOW)

      read_cov = read_data;
      read_cg.sample();

      if (read_data.read_en && !read_data.empty) begin
        if (mem.size() > 0) begin
          ref_data = mem.pop_back();
          data_read++;

          // Validate read data
          if (read_data.data_out === ref_data) begin
            no_of_pass++;
            `uvm_info("SCOREBOARD", $sformatf("PASS! Read: %0d, Expected: %0d FIFO depth: %0d",
                                              read_data.data_out, ref_data, mem.size()), UVM_LOW)
          end else begin
            no_of_fail++;
            `uvm_error("SCOREBOARD", $sformatf(
                       "MISMATCH! Read: %0d, Expected: %0d", read_data.data_out, ref_data))
          end
        end else begin
          `uvm_error("SCOREBOARD", "Read attempted on empty reference model FIFO!")
        end
      end
    end
  endtask

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCOREBOARD", $sformatf(
              "Statistics:\n\tWrites: %0d\n\tReads: %0d\n\tPassed: %0d\n\tFailed: %0d",
              data_written,
              data_read,
              no_of_pass,
              no_of_fail
              ), UVM_LOW)

    if (mem.size() != 0) begin
      `uvm_warning("SCOREBOARD", $sformatf("%0d unread entries in reference model", mem.size()))
    end
  endfunction : report_phase

endclass
