view structure
view signals
view wave
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {System Signals}
add wave -noupdate -format Logic /testbench/reset
add wave -noupdate -divider {Tx Client Interface}
add wave -noupdate -format Logic /testbench/tx_clk
add wave -noupdate -format Logic /testbench/dut/trimac_locallink/tx_enable_int
add wave -noupdate -format Logic /testbench/dut/trimac_locallink/tx_ack
add wave -noupdate -format Logic /testbench/dut/trimac_locallink/tx_data_valid
add wave -noupdate -format Literal -hex /testbench/dut/trimac_locallink/tx_data
add wave -noupdate -divider {Tx Statistics Vector}
add wave -noupdate -format Literal -binary /testbench/tx_statistics_vector
add wave -noupdate -format Logic /testbench/tx_statistics_valid
add wave -noupdate -divider {Rx Client Interface}
add wave -noupdate -format Logic /testbench/rx_clk
add wave -noupdate -format Logic /testbench/dut/trimac_locallink/rx_enable_int
add wave -noupdate -format Logic /testbench/dut/trimac_locallink/rx_data_valid
add wave -noupdate -format Literal -hex /testbench/dut/trimac_locallink/rx_data
add wave -noupdate -format Logic /testbench/dut/trimac_locallink/rx_good_frame
add wave -noupdate -format Logic /testbench/dut/trimac_locallink/rx_bad_frame
add wave -noupdate -divider {Rx Statistics Vector}
add wave -noupdate -format Literal -binary /testbench/rx_statistics_vector
add wave -noupdate -format Logic /testbench/rx_statistics_valid
add wave -noupdate -divider {Flow Control}
add wave -noupdate -format Literal -hex /testbench/pause_val
add wave -noupdate -format Logic /testbench/pause_req
add wave -noupdate -divider {Rx FIFO Local Link Interface}
add wave -noupdate -format logic /testbench/dut/trimac_locallink/rx_ll_sof_out_n
add wave -noupdate -format logic /testbench/dut/trimac_locallink/rx_ll_eof_out_n
add wave -noupdate -format logic /testbench/dut/trimac_locallink/rx_ll_src_rdy_out_n
add wave -noupdate -format logic /testbench/dut/trimac_locallink/rx_ll_dst_rdy_in_n
add wave -noupdate -format logic -hex /testbench/dut/trimac_locallink/rx_ll_data_out
add wave -noupdate -divider {Tx FIFO Local Link Interface}
add wave -noupdate -format logic /testbench/dut/trimac_locallink/tx_ll_sof_in_n
add wave -noupdate -format logic /testbench/dut/trimac_locallink/tx_ll_eof_in_n
add wave -noupdate -format logic /testbench/dut/trimac_locallink/tx_ll_src_rdy_in_n
add wave -noupdate -format logic /testbench/dut/trimac_locallink/tx_ll_dst_rdy_out_n
add wave -noupdate -format logic -hex /testbench/dut/trimac_locallink/tx_ll_data_in
add wave -noupdate -divider {Tx MII Interface}
add wave -noupdate -format Logic /testbench/mii_tx_clk
add wave -noupdate -format Logic /testbench/mii_tx_en
add wave -noupdate -format Logic /testbench/mii_tx_er
add wave -noupdate -format Literal -hex /testbench/mii_txd
add wave -noupdate -divider {Rx MII Interface}
add wave -noupdate -format Logic /testbench/mii_rx_clk
add wave -noupdate -format Logic /testbench/mii_rx_dv
add wave -noupdate -format Logic /testbench/mii_rx_er
add wave -noupdate -format Literal -hex /testbench/mii_rxd
add wave -noupdate -divider {MDIO Interface}
add wave -noupdate -format Logic /testbench/mdc
add wave -noupdate -format Logic /testbench/mdio
add wave -noupdate -divider {Management Interface}
add wave -noupdate -format Logic /testbench/host_clk
add wave -noupdate -format Literal -binary /testbench/dut/host_opcode_reg
add wave -noupdate -format Literal -hex /testbench/dut/host_addr_reg
add wave -noupdate -format Literal -hex /testbench/dut/host_wr_data_reg
add wave -noupdate -format Literal -hex /testbench/dut/host_rd_data
add wave -noupdate -format Logic /testbench/dut/host_miim_sel_reg
add wave -noupdate -format Logic /testbench/dut/host_req_reg
add wave -noupdate -format Logic /testbench/dut/host_miim_rdy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
WaveRestoreZoom {0 ps} {4310754 ps}
