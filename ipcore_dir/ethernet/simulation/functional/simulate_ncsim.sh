#!/bin/sh
mkdir work

echo "Compiling Tri-Mode Ethernet MAC Core Simulation Models"
ncvhdl -v93 -work work ../../../ethernet.vhd

echo "Compiling Example Design"
ncvhdl -v93 -work work \
../../example_design/fifo/tx_client_fifo.vhd \
../../example_design/fifo/rx_client_fifo.vhd \
../../example_design/fifo/ten_100_1g_eth_fifo.vhd \
../../example_design/address_swap_module.vhd \
../../example_design/physical/mii_if.vhd \
../../example_design/sync_block.vhd \
../../example_design/reset_sync.vhd \
../../example_design/ethernet_block.vhd \
../../example_design/ethernet_locallink.vhd \
../../example_design/ethernet_example_design.vhd

echo "Compiling Test Bench"
ncvhdl -v93 -work work ../demo_tb.vhd

echo "Elaborating design"
ncelab -access +r work.testbench:behav

echo "Starting simulation"
ncsim -gui work.testbench:behav -input @"simvision -input wave_ncsim.sv"
