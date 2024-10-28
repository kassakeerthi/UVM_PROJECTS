class trans extends uvm_sequence_item;

  `uvm_object_utils(trans);

  rand bit load;
  rand bit mode;
  rand bit reset;
  rand bit [3:0] data_in;
  bit [3:0] data_out;

  /* `uvm_object_utils_begin(trans)
      `uvm_field_int(load, UVM_ALL_ON)
      `uvm_field_int(mode, UVM_ALL_ON)
      `uvm_field_int(reset, UVM_ALL_ON)
      `uvm_field_int(data_in, UVM_ALL_ON)
      `uvm_field_int(data_out, UVM_ALL_ON)
    `uvm_object_utils_end
*/
  constraint c1 {
    reset dist {
      0 := 10,
      1 := 1
    };
  }

  constraint c2 {
    load dist {
      0 := 4,
      1 := 1
    };
  }

  constraint c3 {
    mode dist {
      0 := 10,
      1 := 10
    };
  }

  constraint c4 {data_in inside {[1 : 10]};}

  function new(string name = "trans");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("load", this.load, 1, UVM_BIN);
    printer.print_field("mode", this.mode, 1, UVM_BIN);
    printer.print_field("reset", this.reset, 1, UVM_BIN);
    printer.print_field("data_in", this.data_in, 4, UVM_DEC);
    printer.print_field("data_out", this.data_out, 4, UVM_DEC);

  endfunction : do_print

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    trans rhs_;
    if (!$cast(rhs_, rhs)) begin
      `uvm_fatal("TRANS", "$cast is failed`")
      return 0;
    end
    return super.do_compare(rhs, comparer) && this.data_out == rhs_.data_out;
  endfunction

endclass




