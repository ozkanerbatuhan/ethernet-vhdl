# SimVision Command Script

#
# groups
#

if {[catch {group new -name {System Signals} -overlay 0}] != ""} {
    group using {System Signals}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :reset \

if {[catch {group new -name {TX Client Interface} -overlay 0}] != ""} {
    group using {TX Client Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :tx_clk \
    :dut.trimac_locallink.tx_enable_int \
    :dut.trimac_locallink.tx_ack \
    :dut.trimac_locallink.tx_data_valid \
    :dut.trimac_locallink.tx_data

if {[catch {group new -name {TX Statistics Vector} -overlay 0}] != ""} {
    group using {TX Statistics Vector}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :tx_statistics_vector \
    :tx_statistics_valid

if {[catch {group new -name {RX Client Interface} -overlay 0}] != ""} {
    group using {RX Client Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :rx_clk \
    :dut.trimac_locallink.rx_enable_int \
    :dut.trimac_locallink.rx_data_valid \
    :dut.trimac_locallink.rx_data \
    :dut.trimac_locallink.rx_good_frame \
    :dut.trimac_locallink.rx_bad_frame

if {[catch {group new -name {RX Statistics Vector} -overlay 0}] != ""} {
    group using {RX Statistics Vector}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :rx_statistics_vector \
    :rx_statistics_valid


if {[catch {group new -name {Flow Control} -overlay 0}] != ""} {
    group using {Flow Control}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :pause_val \
    :pause_req

if {[catch {group new -name {Rx FIFO Local Link Interface} -overlay 0}] != ""} {
    group using {Rx FIFO Local Link Interface}

    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :dut.trimac_locallink.rx_ll_sof_out_n \
    :dut.trimac_locallink.rx_ll_eof_out_n \
    :dut.trimac_locallink.rx_ll_src_rdy_out_n \
    :dut.trimac_locallink.rx_ll_dst_rdy_in_n \
    :dut.trimac_locallink.rx_ll_data_out

if {[catch {group new -name {Tx FIFO Local Link Interface} -overlay 0}] != ""} {
    group using {Tx FIFO Local Link Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :dut.trimac_locallink.tx_ll_sof_in_n \
    :dut.trimac_locallink.tx_ll_eof_in_n \
    :dut.trimac_locallink.tx_ll_src_rdy_in_n \
    :dut.trimac_locallink.tx_ll_dst_rdy_out_n \
    :dut.trimac_locallink.tx_ll_data_in

if {[catch {group new -name {TX MII Interface} -overlay 0}] != ""} {
    group using {TX MII Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :mii_tx_clk \
    :mii_tx_en \
    :mii_tx_er \
    :mii_txd

if {[catch {group new -name {RX MII Interface} -overlay 0}] != ""} {
    group using {RX MII Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :mii_rx_clk \
    :mii_rx_dv \
    :mii_rx_er \
    :mii_rxd 


if {[catch {group new -name {MDIO Interface} -overlay 0}] != ""} {
    group using {MDIO Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :mdc \
    :mdio

if {[catch {group new -name {Management Interface} -overlay 0}] != ""} {
    group using {Management Interface}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    :host_clk \
    :dut.host_opcode_reg \
    :dut.host_addr_reg \
    :dut.host_wr_data_reg \
    :dut.host_rd_data \
    :dut.host_miim_sel_reg \
    :dut.host_req_reg \
    :dut.host_miim_rdy


#
# Waveform windows
#
if {[window find -match exact -name "Waveform 1"] == {}} {
    window new WaveWindow -name "Waveform 1" -geometry 906x585+25+55
} else {
    window geometry "Waveform 1" 906x585+25+55
}
window target "Waveform 1" on
waveform using {Waveform 1}
waveform sidebar visibility partial
waveform set \
    -primarycursor TimeA \
    -signalnames name \
    -signalwidth 175 \
    -units fs \
    -valuewidth 75
cursor set -using TimeA -time 50,000,000,000fs
cursor set -using TimeA -marching 1
waveform baseline set -time 0

set groupId [waveform add -groups {{System Signals}}]

set groupId [waveform add -groups {{TX Client Interface}}]

set groupId [waveform add -groups {{TX Statistics Vector}}]

set groupId [waveform add -groups {{RX Client Interface}}]

set groupId [waveform add -groups {{RX Statistics Vector}}]
set groupId [waveform add -groups {{Flow Control}}]
set groupId [waveform add -groups {{Rx FIFO Local Link Interface}}]
set groupId [waveform add -groups {{Tx FIFO Local Link Interface}}]

set groupId [waveform add -groups {{TX MII Interface}}]

set groupId [waveform add -groups {{RX MII Interface}}]
set groupId [waveform add -groups {{MDIO Interface}}]

set groupId [waveform add -groups {{Management Interface}}]

waveform xview limits 0fs 10us

simcontrol run -time 500us
