class write_trans extends uvm_sequence_item;

  `uvm_object_utils(write_trans);

  rand logic reset, write_en;
  rand logic [7:0] data_in;

  logic full;

  constraint my_c {soft reset == 1'b0;}

  function new(string name = "write_trans");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("reset", this.reset, 1, UVM_BIN);
    printer.print_field("write_en", this.write_en, 1, UVM_BIN);
    printer.print_field("data_in", this.data_in, 8, UVM_DEC);
    printer.print_field("full", this.full, 1, UVM_BIN);

  endfunction : do_print

endclass


