--------------------------------------------------------------------------------
-- File       : ethernet_locallink.vhd
-- Author     : Xilinx Inc.
-- ------------------------------------------------------------------------------
-- (c) Copyright 2004-2009 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES. 
-- ------------------------------------------------------------------------------
-- Description: This is the LocalLink vhdl wrapper for the Tri-Mode
--              Ethernet MAC core.  This wrapper enhances the standard MAC core
--              with an example client FIFO.  The interface to this FIFO is
--              designed to the LocalLink specification, a Xilinx proprietaty
--              interface standard.  Please refer to core documentation for
--              additional FIFO and LocalLink information.
--
--         _________________________________________________________
--        |                                                         |
--        |                    LOCALLINK WRAPPER                    |
--        |                                                         |
--        |   _____________________       ______________________    |
--        |  |  _________________  |     |                      |   |
--        |  | |                 | |     |                      |   |
--  -------->| | TX CLIENT FIFO  | |---->| Tx               Tx  |--------->
--        |  | |                 | |     | client           PHY |   |
--        |  | |_________________| |     | I/F              I/F |   |
--        |  |                     |     |                      |   |
--  Local |  |     10/100/1G       |     |  TRI-MODE ETHERNET   |   |
--  Link  |  |    ETHERNET FIFO    |     |      MAC CORE        |   | PHY I/F
--        |  |                     |     |    BLOCK WRAPPER     |   |
--        |  |  _________________  |     |                      |   |
--        |  | |                 | |     |                      |   |
--  <--------| | RX CLIENT FIFO  | |<----| Rx               Rx  |<---------
--        |  | |                 | |     | client           PHY |   |
--        |  | |_________________| |     | I/F              I/F |   |
--        |  |_____________________|     |______________________|   |
--        |                                                         |
--        |_________________________________________________________|
--


library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


--------------------------------------------------------------------------------
-- The entity declaration for the locallink level wrapper.
--------------------------------------------------------------------------------

entity ethernet_locallink is
    port(
      -- asynchronous reset
      reset                : in  std_logic;

      -- Client Receiver Statistics Interface
      ---------------------------------------
      rx_clk               : out std_logic;
      rx_enable            : out std_logic;
      rx_statistics_vector : out std_logic_vector(27 downto 0);
      rx_statistics_valid  : out std_logic;

      -- Client Receiver (LocalLink) Interface
      ----------------------------------------
      rx_ll_clock          : in  std_logic;
      rx_ll_reset          : in  std_logic;
      rx_ll_data_out       : out std_logic_vector(7 downto 0);
      rx_ll_sof_out_n      : out std_logic;
      rx_ll_eof_out_n      : out std_logic;
      rx_ll_src_rdy_out_n  : out std_logic;
      rx_ll_dst_rdy_in_n   : in  std_logic;

      -- Client Transmitter Statistics Interface
      ------------------------------------------
      tx_clk               : out std_logic;
      tx_enable            : out std_logic;
      tx_ifg_delay         : in  std_logic_vector(7 downto 0);
      tx_statistics_vector : out std_logic_vector(31 downto 0);
      tx_statistics_valid  : out std_logic;

      -- Client Transmitter (LocalLink) Interface
      -------------------------------------------
      tx_ll_clock          : in  std_logic;
      tx_ll_reset          : in  std_logic;
      tx_ll_data_in        : in  std_logic_vector(7 downto 0);
      tx_ll_sof_in_n       : in  std_logic;
      tx_ll_eof_in_n       : in  std_logic;
      tx_ll_src_rdy_in_n   : in  std_logic;
      tx_ll_dst_rdy_out_n  : out std_logic;

      -- MAC Control Interface
      ------------------------
      pause_req            : in  std_logic;
      pause_val            : in  std_logic_vector(15 downto 0);

      -- MII Interface
      -----------------
      mii_txd              : out std_logic_vector(3 downto 0);
      mii_tx_en            : out std_logic;
      mii_tx_er            : out std_logic;
      mii_rxd              : in std_logic_vector(3 downto 0);
      mii_rx_dv            : in std_logic;
      mii_rx_er            : in std_logic;
      mii_rx_clk           : in std_logic;
      mii_tx_clk           : in std_logic;

      -- Initial Unicast Address Value
      unicast_address      : in  std_logic_vector(47 downto 0);

      -- MDIO Interface
      -----------------
      mdio_i               : in  std_logic;
      mdio_o               : out std_logic;
      mdio_t               : out std_logic;
      mdc                  : out std_logic;

      -- Host Interface
      -----------------
      host_clk             : in  std_logic;
      host_opcode          : in  std_logic_vector(1 downto 0);
      host_addr            : in  std_logic_vector(9 downto 0);
      host_wr_data         : in  std_logic_vector(31 downto 0);
      host_req             : in  std_logic;
      host_miim_sel        : in  std_logic;
      host_rd_data         : out std_logic_vector(31 downto 0);
      host_miim_rdy        : out std_logic

      );
end ethernet_locallink;


architecture wrapper of ethernet_locallink is


  ------------------------------------------------------------------------------
  -- Component Declaration for the Tri-Mode EMAC core top wrapper
  ------------------------------------------------------------------------------
  component ethernet_block
    port(
      -- asynchronous reset
      reset                : in  std_logic;

      -- Client Receiver Interface
      ----------------------------
      rx_clk               : out std_logic;
      rx_enable            : out std_logic;
      rx_statistics_vector : out std_logic_vector(27 downto 0);
      rx_statistics_valid  : out std_logic;
      rx_data              : out std_logic_vector(7 downto 0);
      rx_data_valid        : out std_logic;
      rx_good_frame        : out std_logic;
      rx_bad_frame         : out std_logic;

      -- Client Transmitter Interface
      -------------------------------
      tx_clk               : out std_logic;
      tx_enable            : out std_logic;
      tx_ifg_delay         : in  std_logic_vector(7 downto 0);
      tx_statistics_vector : out std_logic_vector(31 downto 0);
      tx_statistics_valid  : out std_logic;
      tx_data              : in  std_logic_vector(7 downto 0);
      tx_data_valid        : in  std_logic;
      tx_ack               : out std_logic;
      tx_underrun          : in  std_logic;

      -- MAC Control Interface
      ------------------------
      pause_req            : in  std_logic;
      pause_val            : in  std_logic_vector(15 downto 0);

      -- MII Interface
      -----------------
      mii_txd              : out std_logic_vector(3 downto 0);
      mii_tx_en            : out std_logic;
      mii_tx_er            : out std_logic;
      mii_rxd              : in std_logic_vector(3 downto 0);
      mii_rx_dv            : in std_logic;
      mii_rx_er            : in std_logic;
      mii_rx_clk           : in std_logic;
      mii_tx_clk           : in std_logic;

      -- Initial Unicast Address Value
      unicast_address      : in  std_logic_vector(47 downto 0);

      -- MDIO Interface
      -----------------
      mdio_i               : in  std_logic;
      mdio_o               : out std_logic;
      mdio_t               : out std_logic;
      mdc                  : out std_logic;

      -- Host Interface
      -----------------
      host_clk             : in  std_logic;
      host_opcode          : in  std_logic_vector(1 downto 0);
      host_addr            : in  std_logic_vector(9 downto 0);
      host_wr_data         : in  std_logic_vector(31 downto 0);
      host_req             : in  std_logic;
      host_miim_sel        : in  std_logic;
      host_rd_data         : out std_logic_vector(31 downto 0);
      host_miim_rdy        : out std_logic
);
   end component;


   ---------------------------------------------------------------------
   -- Component Declaration for the client side FIFO
   ---------------------------------------------------------------------
   component ten_100_1g_eth_fifo
   generic (
      FULL_DUPLEX_ONLY     : boolean);
   port (
      -- Transmit FIFO MAC TX Interface
      tx_clk               : in  std_logic;
      tx_reset             : in  std_logic;
      tx_enable            : in  std_logic;
      tx_data              : out std_logic_vector(7 downto 0);
      tx_data_valid        : out std_logic;
      tx_ack               : in  std_logic;
      tx_underrun          : out std_logic;
      tx_collision         : in  std_logic;
      tx_retransmit        : in  std_logic;

      -- Transmit FIFO LocalLink Interface
      tx_ll_clock          : in  std_logic;
      tx_ll_reset          : in  std_logic;
      tx_ll_data_in        : in  std_logic_vector(7 downto 0);
      tx_ll_sof_in_n       : in  std_logic;
      tx_ll_eof_in_n       : in  std_logic;
      tx_ll_src_rdy_in_n   : in  std_logic;
      tx_ll_dst_rdy_out_n  : out std_logic;
      tx_fifo_status       : out std_logic_vector(3 downto 0);
      tx_overflow          : out std_logic;

      -- Receive FIFO MAC RX Interface
      rx_clk               : in  std_logic;
      rx_reset             : in  std_logic;
      rx_enable            : in  std_logic;
      rx_data              : in  std_logic_vector(7 downto 0);
      rx_data_valid        : in  std_logic;
      rx_good_frame        : in  std_logic;
      rx_bad_frame         : in  std_logic;
      rx_overflow          : out std_logic;

      -- Receive FIFO LocalLink Interface
      rx_ll_clock          : in  std_logic;
      rx_ll_reset          : in  std_logic;
      rx_ll_data_out       : out std_logic_vector(7 downto 0);
      rx_ll_sof_out_n      : out std_logic;
      rx_ll_eof_out_n      : out std_logic;
      rx_ll_src_rdy_out_n  : out std_logic;
      rx_ll_dst_rdy_in_n   : in  std_logic;
      rx_fifo_status       : out std_logic_vector(3 downto 0)
   );
   end component;


  ------------------------------------------------------------------------------
  -- Component declaration for the reset synchroniser
  ------------------------------------------------------------------------------
  component reset_sync
  port (
    reset_in               : in  std_logic;    -- Active high asynchronous reset
    enable                 : in  std_logic;    -- enable reeset removal
    clk                    : in  std_logic;    -- clock to be sync'ed to
    reset_out              : out std_logic     -- "Synchronised" reset signal
    );
  end component;


  ----------------------------------------------------------------------
  -- internal signals used in this locallink level wrapper.
  ----------------------------------------------------------------------

   signal rx_reset_int     : std_logic;   
   signal rx_pre_reset     : std_logic;   
   signal rx_reset         : std_logic;     -- MAC Rx synchronous reset
   signal rx_clk_int       : std_logic;     -- MAC Rx clock
   signal rx_enable_int    : std_logic;     -- MAC Rx clock enable

   signal tx_reset_int     : std_logic;   
   signal tx_pre_reset     : std_logic;   
   signal tx_reset         : std_logic;     -- MAC Tx synchronous reset
   signal tx_clk_int       : std_logic;     -- MAC Tx clock
   signal tx_enable_int    : std_logic;     -- MAC Tx clock enable

   -- MAC receiver client I/F
   signal rx_data          : std_logic_vector(7 downto 0);
   signal rx_data_valid    : std_logic;
   signal rx_good_frame    : std_logic;
   signal rx_bad_frame     : std_logic;

   -- MAC transmitter client I/F
   signal tx_data          : std_logic_vector(7 downto 0);
   signal tx_data_valid    : std_logic;
   signal tx_ack           : std_logic;
   signal tx_underrun      : std_logic;

   -- Note: KEEP attributes preserve signal names so they can be displayed in
   --            simulator wave windows
   attribute keep : string;
   attribute keep of tx_data       : signal is "true";
   attribute keep of tx_data_valid : signal is "true";
   attribute keep of tx_ack        : signal is "true";
   attribute keep of tx_underrun   : signal is "true";
   attribute keep of rx_data       : signal is "true";
   attribute keep of rx_data_valid : signal is "true";
   attribute keep of rx_good_frame : signal is "true";
   attribute keep of rx_bad_frame  : signal is "true";
   attribute keep of tx_enable_int : signal is "true";
   attribute keep of rx_enable_int : signal is "true";


begin


  ------------------------------------------------------------------------------
  -- Connect the output clock signals
  ------------------------------------------------------------------------------

   rx_clk          <= rx_clk_int;
   rx_enable       <= rx_enable_int;
   tx_enable       <= tx_enable_int;

   tx_clk          <= tx_clk_int;


  ----------------------------------------------------------------------
  -- Create synchronous reset signals for use in the Address swapping and FIFO
  -- modules.  A synchronous reset signal is created in each clock domain.
  ----------------------------------------------------------------------

  -- Create synchronous reset in the transmitter clock domain.
   tx_reset_gen : reset_sync
   port map(
      clk            => tx_clk_int,
      enable         => '1',
      reset_in       => reset,
      reset_out      => tx_reset_int
   );

  -- Create fully synchronous reset in the Tx clock domain.
  gen_tx_reset : process (tx_clk_int)
  begin
    if tx_clk_int'event and tx_clk_int = '1' then
       if tx_reset_int = '1' then
         tx_pre_reset      <= '1';
         tx_reset          <= '1';
       else
         tx_pre_reset      <= '0';
         tx_reset          <= tx_pre_reset;
       end if;
    end if;
  end process gen_tx_reset;

  -- Create synchronous reset in the receiver clock domain.
   rx_reset_gen : reset_sync
   port map(
      clk            => rx_clk_int,
      enable         => '1',
      reset_in       => reset,
      reset_out      => rx_reset_int
   );

  -- Create fully synchronous reset in the Rx clock domain.
  gen_rx_reset : process (rx_clk_int)
  begin
    if rx_clk_int'event and rx_clk_int = '1' then
       if rx_reset_int = '1' then
         rx_pre_reset      <= '1';
         rx_reset          <= '1';
       else
         rx_pre_reset      <= '0';
         rx_reset          <= rx_pre_reset;
       end if;
    end if;
  end process gen_rx_reset;


  ------------------------------------------------------------------------------
  -- Instantiate the Tri-Mode EMAC core Block wrapper
  ------------------------------------------------------------------------------
  trimac_block : ethernet_block
    port map (
      -- asynchronous reset
      reset                 => reset,

      -- Receiver Interface.
      rx_clk                => rx_clk_int,
      rx_enable             => rx_enable_int,
      rx_statistics_vector  => rx_statistics_vector,
      rx_statistics_valid   => rx_statistics_valid,
      rx_data               => rx_data,
      rx_data_valid         => rx_data_valid,
      rx_good_frame         => rx_good_frame,
      rx_bad_frame          => rx_bad_frame,

      -- Transmitter Interface
      tx_clk                => tx_clk_int,
      tx_enable             => tx_enable_int,
      tx_ifg_delay          => tx_ifg_delay,
      tx_statistics_vector  => tx_statistics_vector,
      tx_statistics_valid   => tx_statistics_valid,
      tx_data               => tx_data,
      tx_data_valid         => tx_data_valid,
      tx_ack                => tx_ack,
      tx_underrun           => tx_underrun,

      -- Flow Control
      pause_req             => pause_req,
      pause_val             => pause_val,

      -- MII Interface
      mii_txd               => mii_txd,
      mii_tx_en             => mii_tx_en,
      mii_tx_er             => mii_tx_er,
      mii_rxd               => mii_rxd,
      mii_rx_dv             => mii_rx_dv,
      mii_rx_er             => mii_rx_er,
      mii_rx_clk            => mii_rx_clk,
      mii_tx_clk            => mii_tx_clk,

      -- Initial Unicast Address Value
      unicast_address       => unicast_address,

      -- MDIO Interface
      mdc                   => mdc,
      mdio_i                => mdio_i,
      mdio_o                => mdio_o,
      mdio_t                => mdio_t,

      -- Host Interface
      host_clk              => host_clk,
      host_opcode           => host_opcode,
      host_addr             => host_addr,
      host_wr_data          => host_wr_data,
      host_rd_data          => host_rd_data,
      host_miim_sel         => host_miim_sel,
      host_req              => host_req,
      host_miim_rdy         => host_miim_rdy
  );


  ------------------------------------------------------------------------------
  -- Instantiate the client side FIFO
  -----------------------------------------------------------------------------

  client_side_FIFO : ten_100_1g_eth_fifo
    generic map (
      FULL_DUPLEX_ONLY      => true
    )
    port map (
      -- Transmit FIFO MAC TX Interface
      tx_clk                => tx_clk_int,
      tx_reset              => tx_reset,
      tx_enable             => tx_enable_int,
      tx_data               => tx_data,
      tx_data_valid         => tx_data_valid,
      tx_ack                => tx_ack,
      tx_underrun           => tx_underrun,
      tx_collision          => '0',
      tx_retransmit         => '0',

      -- Transmit FIFO Local-link Interface
      tx_ll_clock           => tx_ll_clock,
      tx_ll_reset           => tx_ll_reset,
      tx_ll_data_in         => tx_ll_data_in,
      tx_ll_sof_in_n        => tx_ll_sof_in_n,
      tx_ll_eof_in_n        => tx_ll_eof_in_n,
      tx_ll_src_rdy_in_n    => tx_ll_src_rdy_in_n,
      tx_ll_dst_rdy_out_n   => tx_ll_dst_rdy_out_n,
      tx_fifo_status        => open,
      tx_overflow           => open,

      -- Receive FIFO MAC RX Interface
      rx_clk                => rx_clk_int,
      rx_reset              => rx_reset,
      rx_enable             => rx_enable_int,
      rx_data               => rx_data,
      rx_data_valid         => rx_data_valid,
      rx_good_frame         => rx_good_frame,
      rx_bad_frame          => rx_bad_frame,
      rx_overflow           => open,

      -- Receive FIFO Local-link Interface
      rx_ll_clock           => rx_ll_clock,
      rx_ll_reset           => rx_ll_reset,
      rx_ll_data_out        => rx_ll_data_out,
      rx_ll_sof_out_n       => rx_ll_sof_out_n,
      rx_ll_eof_out_n       => rx_ll_eof_out_n,
      rx_ll_src_rdy_out_n   => rx_ll_src_rdy_out_n,
      rx_ll_dst_rdy_in_n    => rx_ll_dst_rdy_in_n,
      rx_fifo_status        => open
    );


end wrapper;
