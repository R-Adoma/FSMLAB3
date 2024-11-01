#!/bin/sh

#cleanup

rm -rf obj_dir
rm -f f1_start.vcd


#Attach Vbuddy
~/Documents/iac/lab0-devtools/tools/attach_usb.sh

# run Verilator to translate Verilog into C++, including C++ testing
verilator -Wall --cc --trace f1_start.sv --exe f1_start_tb.cpp

# build C++ project via make automatically generated by Verilator 
make -j -C obj_dir/ -f Vf1_start.mk Vf1_start

# run executable simulation file
obj_dir/Vf1_start