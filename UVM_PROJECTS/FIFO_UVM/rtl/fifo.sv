module fifo (
    clk,
    reset,
    read_en,
    write_en,
    data_in,
    data_out,
    empty,
    full
);

  input logic clk, reset;
  input logic read_en, write_en;
  input logic [7:0] data_in;
  output logic [7:0] data_out;
  output logic empty, full;

  integer i;

  // Memory
  logic [7:0] mem[16];

  // Read and Write pointer
  logic [4:0] read_ptr, write_ptr;

  // Logic for read and write pointer
  always @(posedge clk) begin
    if (reset) begin
      read_ptr  <= 5'b0;
      write_ptr <= 5'b0;
    end else if (read_en && ~empty) begin
      read_ptr <= read_ptr + 1;
    end else if (write_en && ~full) begin
      write_ptr <= write_ptr + 1;
    end
  end

  // Logic for write and read logic
  always @(posedge clk) begin
    if (reset) begin
      for (i = 0; i < 16; i = i + 1) begin
        mem[i]   <= 8'b0;
        data_out <= 8'b0;
      end
    end else begin
      if (read_en && ~empty) data_out <= mem[read_ptr[3:0]];
      else if (write_en && ~full) mem[write_ptr[3:0]] <= data_in;
    end
  end

  // Empty & Full

  assign empty = (read_ptr == write_ptr);
  assign full  = (read_ptr == {~write_ptr[4], write_ptr[3:0]});

  // NOTE: Assertions

  // Basic Protocol Assertions
  property reset_clears_pointers;
    @(posedge clk) $rose(
        reset
    ) |-> ##1 (read_ptr == 0 && write_ptr == 0);
  endproperty

  property write_updates_pointer;
    @(posedge clk) disable iff (reset) (write_en && !full) |-> ##1 (write_ptr != $past(
        write_ptr
    ));
  endproperty

  property read_updates_pointer;
    @(posedge clk) disable iff (reset) (read_en && !empty) |-> ##1 (read_ptr != $past(
        read_ptr
    ));
  endproperty

  // FIFO Functionality Assertions
  property fifo_full_condition;
    @(posedge clk) disable iff (reset) full |-> (read_ptr == {~write_ptr[4], write_ptr[3:0]});
  endproperty

  property fifo_empty_condition;
    @(posedge clk) disable iff (reset) empty |-> (read_ptr == write_ptr);
  endproperty

  // Liveness Properties
  property eventual_read_after_write;
    @(posedge clk) disable iff (reset) (write_en && !full) |-> ##[1:16] (!empty);
  endproperty

  // Assertion Bindings
  a_reset_clears_pointers :
  assert property (reset_clears_pointers)
  else $error("Reset did not clear pointers");

  a_write_updates_pointer :
  assert property (write_updates_pointer)
  else $error("Write pointer not updated after write");

  a_read_updates_pointer :
  assert property (read_updates_pointer)
  else $error("Read pointer not updated after read");

  a_fifo_full_condition :
  assert property (fifo_full_condition)
  else $error("FIFO full condition mismatch");

  a_fifo_empty_condition :
  assert property (fifo_empty_condition)
  else $error("FIFO empty condition mismatch");

  a_eventual_read_after_write :
  assert property (eventual_read_after_write)
  else $error("Written data not readable within bounded time");

  // Assume properties (constraints on inputs)
  a_reset_stability :
  assume property (@(posedge clk) $rose(reset) |-> ##[0:3] $stable(reset))
  else $error("Reset deasserted too quickly");


  FULL :
  cover property (@(posedge clk) !full ##1 full);

  EMPTY :
  cover property (@(posedge clk) !empty ##1 empty);

  RCP :
  cover property (reset_clears_pointers);

  WUP :
  cover property (write_updates_pointer);

  RUP :
  cover property (read_updates_pointer);

  FFC :
  cover property (fifo_full_condition);

  FEC :
  cover property (fifo_empty_condition);

  ERAW :
  cover property (eventual_read_after_write);

endmodule
