class trans extends uvm_sequence_item;

  `uvm_object_utils(trans);

  rand logic rst_h;
  logic [3:0] out;

  constraint my_c {
    rst_h dist {
      1 := 1,  // prob = 1/21
      0 := 20  // prob =  20/21
    };
  }

  function new(string name = "trans");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("rst_h", this.rst_h, 1, UVM_DEC);
    printer.print_field("out", this.out, 4, UVM_DEC);

  endfunction : do_print

endclass


