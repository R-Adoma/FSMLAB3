module f1_fsm_clk #(
    parameter WIDTH = 16
)(
  // interface signals
  output logic cmd_seq,
  input  logic             clk,      // clock 
  input  logic             rst,      // reset
  input  logic             en,       // enable signal
  output logic cmd_delay,
  input logic trigger,
  output logic  [7:0] data_out,
);
    logic [6:0] K;
    logic [4:0] N = 5'd51;
    logic tick;
    logic time_out;
    logic mux_out;

lfsr_7 shift_reg(
    .clk(clk),
    .rst(rst),
    .en(en),
    .data_out(K)
);
 
clktick ticker (
    .clk (clk),
    .rst (rst),
    .en (cmd_seq),
    .N(N),
    .tick(tick)
);

delay delayer(
    .clk (clk),
    .rst(rst),
    .trigger (cmd_delay),
    .n(K),
    .time_out (time_out)
);

f1_fsm fsm(
    .rst(rst),
    .en(en),
    .clk(mux_out),
    .data_out(data_out)
);

    always_comb
        mux_out = (cmd_seq & tick) | (!(cmd_seq) & time_out);

endmodule
