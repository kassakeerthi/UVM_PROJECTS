class fsm_seqs extends uvm_sequence #(trans);

  `uvm_object_utils(fsm_seqs);

  function new(string name = "fsm_seqs");
    super.new(name);
  endfunction

  task body();

    req = trans::type_id::create("req");
    start_item(req);
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
    assert (req.randomize() with {reset == 1'b1;});
    finish_item(req);

  endtask : body


endclass
