#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vf1_start.h"

#include "vbuddy.cpp"     // include vbuddy code
#define CYCLES 1000000

int main(int argc, char **argv, char **env) {
  int simcyc;     // simulation clock count
  int tick;       // each clk cycle has two ticks for two edges

  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  Vf1_start* top = new Vf1_start;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("f1_start.vcd");
 
  // init Vbuddy
  if (vbdOpen()!=1) return(-1);
  vbdHeader("F1 Vroom!");
  //vbdSetMode(1);        // Flag mode set to one-shot

  // initialize simulation inputs
  top->clk = 1;
  top->rst = 0;
  top->en = 1;


  // run simulation for MAX_SIM_CYC clock cycles
  for (simcyc=0; simcyc< CYCLES; simcyc++) {
    // dump variables into VCD file and toggle clock
    for (tick=0; tick<2; tick++) {
      tfp->dump (2*simcyc+tick);
      top->clk = !top->clk;
      top->eval ();
    }

    vbdBar(top->data_out & 0xFF);
    
    // top->en = vbdFlag();
    top->rst = (simcyc < 2);
    top->en = (!(simcyc % 60));

    if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
      exit(0);                // ... exit if finish OR 'q' pressed
  }

  vbdClose();     // ++++
  tfp->close(); 
  exit(0);
}