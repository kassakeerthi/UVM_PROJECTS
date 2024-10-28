module counter (
    clk,
    rst_h,
    out
);

  input logic clk, rst_h;
  output logic [3:0] out;

  always_ff @(posedge clk or posedge rst_h) begin
    if (rst_h) begin
      out <= 4'b0;
    end else begin
      out <= out + 1;
    end
  end

endmodule
