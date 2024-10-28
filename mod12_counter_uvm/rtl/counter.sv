module counter (
    input clk,
    input load,
    input mode,
    input reset,
    input [3:0] data_in,
    output logic [3:0] data_out
);

  always_ff @(posedge clk) begin

    if (reset) begin
      data_out <= 4'd0;
    end else if (load) begin
      data_out <= data_in;
    end else begin
      // mode = 1 ,up counter
      if (mode) begin

        if (data_out == 4'd11) begin
          data_out <= 4'd0;
        end else begin
          data_out <= data_out + 4'd1;
        end
        // mode = 0 , down counter
      end else begin

        if (data_out == 0) begin
          data_out <= 4'd11;
        end else begin
          data_out <= data_out - 4'd1;
        end

      end

    end

  end

endmodule : counter
