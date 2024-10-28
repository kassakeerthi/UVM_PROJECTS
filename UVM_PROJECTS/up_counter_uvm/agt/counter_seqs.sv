class counter_seqs extends uvm_sequence #(trans);

  `uvm_object_utils(counter_seqs);

  function new(string name = "counter_seqs");
    super.new(name);
  endfunction

  task body();

    req = trans::type_id::create("req");
    start_item(req);
    // assert (req.randomize() with {rst_h == 1'b1;});
    assert (req.randomize());
    finish_item(req);

  endtask : body

endclass


class reset_seqs extends uvm_sequence #(trans);

  `uvm_object_utils(reset_seqs)

  function new(string name = "reset_seqs");
    super.new(name);
  endfunction

  task body();

    req = trans::type_id::create("req");
    start_item(req);
    assert (req.randomize() with {rst_h == 1'b1;});
    finish_item(req);

  endtask : body


endclass
