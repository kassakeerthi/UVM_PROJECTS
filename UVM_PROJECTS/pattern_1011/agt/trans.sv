class trans extends uvm_sequence_item;

  `uvm_object_utils(trans);

  rand logic reset;
  rand logic in;
  logic out;

  constraint reset_c {
    reset dist {
      1 := 1,  // prob = 1/21
      0 := 20  // prob =  20/21
    };
  }

  constraint in_c {
    in dist {
      1 := 3,  // prob = 3/4
      0 := 1  // prob =  1/4
    };
  }

  function new(string name = "trans");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("reset", this.reset, 1, UVM_BIN);
    printer.print_field("out", this.out, 1, UVM_BIN);

  endfunction : do_print

endclass


