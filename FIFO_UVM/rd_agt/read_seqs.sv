class read_seqs extends uvm_sequence #(read_trans);

  `uvm_object_utils(read_seqs);

  function new(string name = "read_seqs");
    super.new(name);
  endfunction

  task body();

    `uvm_info("READ_SEQS", "This is tasd body", UVM_LOW)

    repeat (5) begin
      req = read_trans::type_id::create("req");
      start_item(req);
      assert (req.randomize() with {read_en == 1'b1;});
      finish_item(req);
    end

    req = read_trans::type_id::create("req");
    start_item(req);
    req.read_en = 0;
    finish_item(req);

  endtask : body

endclass


class low_read_seqs extends uvm_sequence #(read_trans);

  `uvm_object_utils(low_read_seqs);

  function new(string name = "low_read_seqs");
    super.new(name);
  endfunction

  task body();

    `uvm_info("LOW_READ_SEQS", "This is tasd body", UVM_LOW)

    repeat (5) begin
      req = read_trans::type_id::create("req");
      start_item(req);
      assert (req.randomize() with {read_en == 1'b0;});
      finish_item(req);
    end

    req = read_trans::type_id::create("req");
    start_item(req);
    req.read_en = 0;
    finish_item(req);

  endtask : body

endclass


