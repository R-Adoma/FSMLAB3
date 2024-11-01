module f1_fsm_clk #(
    parameter WIDTH = 16
)(
  // interface signals
  input  logic             clk,      // clock 
  input  logic             rst,      // reset
  input  logic             en,       // enable signal
  input  logic [WIDTH-1:0] N,     	 // clock divided by N+1
  output logic  [7:0] data_out,
  output logic tick
);

    // logic tick;

clktick ticker (
    .clk (clk),
    .rst (rst),
    .en (en),
    .N(N),
    .tick(tick)
);

f1_fsm fsm(
    .rst(rst),
    .en(en),
    .clk(tick),
    .data_out(data_out)
);
endmodule
