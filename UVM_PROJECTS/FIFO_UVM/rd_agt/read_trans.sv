class read_trans extends uvm_sequence_item;

  `uvm_object_utils(read_trans);

  rand logic read_en;

  logic [7:0] data_out;
  logic empty;

  function new(string name = "read_trans");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("read_en", this.read_en, 1, UVM_BIN);
    printer.print_field("data_out", this.data_out, 8, UVM_DEC);
    printer.print_field("empty", this.empty, 1, UVM_BIN);

  endfunction : do_print

endclass


