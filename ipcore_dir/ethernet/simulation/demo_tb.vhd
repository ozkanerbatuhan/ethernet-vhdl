--------------------------------------------------------------------------------
-- Title      : Demo testbench
-- Project    : Tri-Mode Ethernet MAC
--------------------------------------------------------------------------------
-- File       : demo_tb.vhd
-- ------------------------------------------------------------------------------
-- (c) Copyright 2004-2008 Xilinx, Inc. All rights reserved.
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
-- Description: This testbench will exercise the ports of the MAC core
--              to demonstrate the functionality.
--------------------------------------------------------------------------------
--
-- This testbench performs the following operations on the MAC core
-- and its design example:

--  - The clock divide register is set for MDIO operation.
--  - Flow control is disabled on both transmit and receive.

--  - Four frames are then pushed into the receiver from the PHY
--    interface (GMII or RGMII):
--    The first is of minimum length (Length/Type = Length = 46 bytes).
--    The second frame sets Length/Type to Type = 0x8000.
--    The third frame has an error inserted.
--    The fourth frame only sends 4 bytes of data: the remainder of the
--    data field is padded up to the minimum frame length i.e. 46 bytes.

--  - These frames are then parsed from the MAC into the MAC's design
--    example.  The design example provides a MAC client loopback
--    function so that frames which are received without error will be
--    looped back to the MAC transmitter and transmitted back to the
--    testbench.  The testbench verifies that this data matches that
--    previously injected into the receiver.

------------------------------------------------------------------------
--                         DEMONSTRATION TESTBENCH                     |
--                                                                     |
--                                                                     |
--     ----------------------------------------------                  |
--     |           TOP LEVEL WRAPPER (DUT)          |                  |
--     |  -------------------    ----------------   |                  |
--     |  | CLIENT LOOPBACK |    | TRI-MODE     |   |                  |
--     |  | DESIGN EXAMPLE  |    | ETHERNET MAC |   |                  |
--     |  |                 |    | CORE         |   |                  |
--     |  |                 |    |              |   |       Monitor    |
--     |  |         ------->|--->|          Tx  |-------->  Frames     |
--     |  |         |       |    |          PHY |   |                  |
--     |  |         |       |    |          I/F |   |                  |
--     |  |         |       |    |              |   |                  |
--     |  |         |       |    |              |   |                  |
--     |  |         |       |    |              |   |                  |
--     |  |         |       |    |          Rx  |   |                  |
--     |  |         |       |    |          PHY |   |                  |
--     |  |         --------|<---|          I/F |<-------- Generate    |
--     |  |                 |    |              |   |      Frames      |
--     |  -------------------    ----------------   |                  |
--     --------------------------------^-------------                  |
--                                     |                               |
--                                     |                               |
--                                 Stimulate                           |
--                               Management I/F                        |
--                               (if present)                          |
--                                                                     |
------------------------------------------------------------------------



entity testbench is
end testbench;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture behav of testbench is

  ------------------------------------------------------------------------------
  -- Component Declaration for Device Under Test (DUT).
  ------------------------------------------------------------------------------
  component ethernet_example_design
    port(
      -- asynchronous reset
      reset                : in  std_logic;


      -- Client Receiver Statistics Interface
      ---------------------------------------
      rx_clk               : out std_logic;
      rx_statistics_vector : out std_logic;
      rx_statistics_valid  : out std_logic;

      -- Client Transmitter Statistics Interface
      ------------------------------------------
      tx_clk               : out std_logic;
      tx_statistics_vector : out std_logic;
      tx_statistics_valid  : out std_logic;

     -- MAC Control Interface
      ------------------------
      pause_req            : in  std_logic;
      pause_val            : in  std_logic;

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


      -- MDIO Interface
      -----------------
      mdio                 : inout  std_logic;
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


  ------------------------------------------------------------------------------
  -- Constants for Configuration Register Addresses
  ------------------------------------------------------------------------------

  -- Management configuration register address (0x340)
  constant config_management_add : std_logic_vector(8 downto 0) := "101000000";

  -- Flow control configuration register address (0x2C0)
  constant config_flow_ctrl_add  : std_logic_vector(8 downto 0) := "011000000";

  -- Receiver configuration register address  (0x240)
  constant receiver_add          : std_logic_vector(8 downto 0) := "001000000";

  -- Transmitter configuration register address (0x280)
  constant transmitter_add       : std_logic_vector(8 downto 0) := "010000000";

  -- EMAC configuration register address (0x300)
  constant emac_config_add       : std_logic_vector(8 downto 0) := "100000000";
  -- Unicast Word 0 configuration register address (0x380)
  constant config_uni0_ctrl_add : std_logic_vector(8 downto 0) := "110000000";

  -- Unicast Word 1 configuration register address (0x384)
  constant config_uni1_ctrl_add : std_logic_vector(8 downto 0) := "110000100";

  -- Address Filter configuration register address (0x390)
  constant config_addr_ctrl_add : std_logic_vector(8 downto 0) := "110010000";


  ------------------------------------------------------------------------------
  -- types to support frame data
  ------------------------------------------------------------------------------
  -- Tx Data and Data_valid record
  type data_typ is record
      data : bit_vector(7 downto 0);        -- data
      valid : bit;                          -- data_valid
      error : bit;                          -- data_error
  end record;
  type frame_of_data_typ is array (natural range <>) of data_typ;

  -- Tx Data, Data_valid and underrun record
  type frame_typ is record
      columns   : frame_of_data_typ(0 to 65);-- data field
      bad_frame : boolean;                   -- does this frame contain an error?
  end record;
  type frame_typ_ary is array (natural range <>) of frame_typ;


  ------------------------------------------------------------------------------
  -- Stimulus - Frame data
  ------------------------------------------------------------------------------
  -- The following constant holds the stimulus for the testbench. It is
  -- an ordered array of frames, with frame 0 the first to be injected
  -- into the core transmit interface by the testbench.
  ------------------------------------------------------------------------------
  constant frame_data : frame_typ_ary := (
   -------------
   -- Frame 0
   -------------
    0          => (
      columns  => (
        0      => ( DATA => X"DA", VALID => '1', ERROR => '0'), -- Destination Address (DA)
        1      => ( DATA => X"02", VALID => '1', ERROR => '0'),
        2      => ( DATA => X"03", VALID => '1', ERROR => '0'),
        3      => ( DATA => X"04", VALID => '1', ERROR => '0'),
        4      => ( DATA => X"05", VALID => '1', ERROR => '0'),
        5      => ( DATA => X"06", VALID => '1', ERROR => '0'),
        6      => ( DATA => X"5A", VALID => '1', ERROR => '0'), -- Source Address (5A)
        7      => ( DATA => X"02", VALID => '1', ERROR => '0'),
        8      => ( DATA => X"03", VALID => '1', ERROR => '0'),
        9      => ( DATA => X"04", VALID => '1', ERROR => '0'),
       10      => ( DATA => X"05", VALID => '1', ERROR => '0'),
       11      => ( DATA => X"06", VALID => '1', ERROR => '0'),
       12      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       13      => ( DATA => X"2E", VALID => '1', ERROR => '0'), -- Length/Type = Length = 46
       14      => ( DATA => X"01", VALID => '1', ERROR => '0'),
       15      => ( DATA => X"02", VALID => '1', ERROR => '0'),
       16      => ( DATA => X"03", VALID => '1', ERROR => '0'),
       17      => ( DATA => X"04", VALID => '1', ERROR => '0'),
       18      => ( DATA => X"05", VALID => '1', ERROR => '0'),
       19      => ( DATA => X"06", VALID => '1', ERROR => '0'),
       20      => ( DATA => X"07", VALID => '1', ERROR => '0'),
       21      => ( DATA => X"08", VALID => '1', ERROR => '0'),
       22      => ( DATA => X"09", VALID => '1', ERROR => '0'),
       23      => ( DATA => X"0A", VALID => '1', ERROR => '0'),
       24      => ( DATA => X"0B", VALID => '1', ERROR => '0'),
       25      => ( DATA => X"0C", VALID => '1', ERROR => '0'),
       26      => ( DATA => X"0D", VALID => '1', ERROR => '0'),
       27      => ( DATA => X"0E", VALID => '1', ERROR => '0'),
       28      => ( DATA => X"0F", VALID => '1', ERROR => '0'),
       29      => ( DATA => X"10", VALID => '1', ERROR => '0'),
       30      => ( DATA => X"11", VALID => '1', ERROR => '0'),
       31      => ( DATA => X"12", VALID => '1', ERROR => '0'),
       32      => ( DATA => X"13", VALID => '1', ERROR => '0'),
       33      => ( DATA => X"14", VALID => '1', ERROR => '0'),
       34      => ( DATA => X"15", VALID => '1', ERROR => '0'),
       35      => ( DATA => X"16", VALID => '1', ERROR => '0'),
       36      => ( DATA => X"17", VALID => '1', ERROR => '0'),
       37      => ( DATA => X"18", VALID => '1', ERROR => '0'),
       38      => ( DATA => X"19", VALID => '1', ERROR => '0'),
       39      => ( DATA => X"1A", VALID => '1', ERROR => '0'),
       40      => ( DATA => X"1B", VALID => '1', ERROR => '0'),
       41      => ( DATA => X"1C", VALID => '1', ERROR => '0'),
       42      => ( DATA => X"1D", VALID => '1', ERROR => '0'),
       43      => ( DATA => X"1E", VALID => '1', ERROR => '0'),
       44      => ( DATA => X"1F", VALID => '1', ERROR => '0'),
       45      => ( DATA => X"20", VALID => '1', ERROR => '0'),
       46      => ( DATA => X"21", VALID => '1', ERROR => '0'),
       47      => ( DATA => X"22", VALID => '1', ERROR => '0'),
       48      => ( DATA => X"23", VALID => '1', ERROR => '0'),
       49      => ( DATA => X"24", VALID => '1', ERROR => '0'),
       50      => ( DATA => X"25", VALID => '1', ERROR => '0'),
       51      => ( DATA => X"26", VALID => '1', ERROR => '0'),
       52      => ( DATA => X"27", VALID => '1', ERROR => '0'),
       53      => ( DATA => X"28", VALID => '1', ERROR => '0'),
       54      => ( DATA => X"29", VALID => '1', ERROR => '0'),
       55      => ( DATA => X"2A", VALID => '1', ERROR => '0'),
       56      => ( DATA => X"2B", VALID => '1', ERROR => '0'),
       57      => ( DATA => X"2C", VALID => '1', ERROR => '0'),
       58      => ( DATA => X"2D", VALID => '1', ERROR => '0'),
       59      => ( DATA => X"2E", VALID => '1', ERROR => '0'), -- 46th Byte of Data
       others  => ( DATA => X"00", VALID => '0', ERROR => '0')),

      -- No error in this frame
      bad_frame => false),


   -------------
   -- Frame 1
   -------------
    1          => (
      columns  => (
        0      => ( DATA => X"DA", VALID => '1', ERROR => '0'), -- Destination Address (DA)
        1      => ( DATA => X"02", VALID => '1', ERROR => '0'),
        2      => ( DATA => X"03", VALID => '1', ERROR => '0'),
        3      => ( DATA => X"04", VALID => '1', ERROR => '0'),
        4      => ( DATA => X"05", VALID => '1', ERROR => '0'),
        5      => ( DATA => X"06", VALID => '1', ERROR => '0'),
        6      => ( DATA => X"5A", VALID => '1', ERROR => '0'), -- Source Address (5A)
        7      => ( DATA => X"02", VALID => '1', ERROR => '0'),
        8      => ( DATA => X"03", VALID => '1', ERROR => '0'),
        9      => ( DATA => X"04", VALID => '1', ERROR => '0'),
       10      => ( DATA => X"05", VALID => '1', ERROR => '0'),
       11      => ( DATA => X"06", VALID => '1', ERROR => '0'),
       12      => ( DATA => X"80", VALID => '1', ERROR => '0'), -- Length/Type = Type = 8000
       13      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       14      => ( DATA => X"01", VALID => '1', ERROR => '0'),
       15      => ( DATA => X"02", VALID => '1', ERROR => '0'),
       16      => ( DATA => X"03", VALID => '1', ERROR => '0'),
       17      => ( DATA => X"04", VALID => '1', ERROR => '0'),
       18      => ( DATA => X"05", VALID => '1', ERROR => '0'),
       19      => ( DATA => X"06", VALID => '1', ERROR => '0'),
       20      => ( DATA => X"07", VALID => '1', ERROR => '0'),
       21      => ( DATA => X"08", VALID => '1', ERROR => '0'),
       22      => ( DATA => X"09", VALID => '1', ERROR => '0'),
       23      => ( DATA => X"0A", VALID => '1', ERROR => '0'),
       24      => ( DATA => X"0B", VALID => '1', ERROR => '0'),
       25      => ( DATA => X"0C", VALID => '1', ERROR => '0'),
       26      => ( DATA => X"0D", VALID => '1', ERROR => '0'),
       27      => ( DATA => X"0E", VALID => '1', ERROR => '0'),
       28      => ( DATA => X"0F", VALID => '1', ERROR => '0'),
       29      => ( DATA => X"10", VALID => '1', ERROR => '0'),
       30      => ( DATA => X"11", VALID => '1', ERROR => '0'),
       31      => ( DATA => X"12", VALID => '1', ERROR => '0'),
       32      => ( DATA => X"13", VALID => '1', ERROR => '0'),
       33      => ( DATA => X"14", VALID => '1', ERROR => '0'),
       34      => ( DATA => X"15", VALID => '1', ERROR => '0'),
       35      => ( DATA => X"16", VALID => '1', ERROR => '0'),
       36      => ( DATA => X"17", VALID => '1', ERROR => '0'),
       37      => ( DATA => X"18", VALID => '1', ERROR => '0'),
       38      => ( DATA => X"19", VALID => '1', ERROR => '0'),
       39      => ( DATA => X"1A", VALID => '1', ERROR => '0'),
       40      => ( DATA => X"1B", VALID => '1', ERROR => '0'),
       41      => ( DATA => X"1C", VALID => '1', ERROR => '0'),
       42      => ( DATA => X"1D", VALID => '1', ERROR => '0'),
       43      => ( DATA => X"1E", VALID => '1', ERROR => '0'),
       44      => ( DATA => X"1F", VALID => '1', ERROR => '0'),
       45      => ( DATA => X"20", VALID => '1', ERROR => '0'),
       46      => ( DATA => X"21", VALID => '1', ERROR => '0'),
       47      => ( DATA => X"22", VALID => '1', ERROR => '0'),
       48      => ( DATA => X"23", VALID => '1', ERROR => '0'),
       49      => ( DATA => X"24", VALID => '1', ERROR => '0'),
       50      => ( DATA => X"25", VALID => '1', ERROR => '0'),
       51      => ( DATA => X"26", VALID => '1', ERROR => '0'),
       52      => ( DATA => X"27", VALID => '1', ERROR => '0'),
       53      => ( DATA => X"28", VALID => '1', ERROR => '0'),
       54      => ( DATA => X"29", VALID => '1', ERROR => '0'),
       55      => ( DATA => X"2A", VALID => '1', ERROR => '0'),
       56      => ( DATA => X"2B", VALID => '1', ERROR => '0'),
       57      => ( DATA => X"2C", VALID => '1', ERROR => '0'),
       58      => ( DATA => X"2D", VALID => '1', ERROR => '0'),
       59      => ( DATA => X"2E", VALID => '1', ERROR => '0'),
       60      => ( DATA => X"2F", VALID => '1', ERROR => '0'), -- 47th Data byte
       others  => ( DATA => X"00", VALID => '0', ERROR => '0')),

      -- No error in this frame
      bad_frame => false),


   -------------
   -- Frame 2
   -------------
    2          => (
      columns  => (
        0      => ( DATA => X"DA", VALID => '1', ERROR => '0'), -- Destination Address (DA)
        1      => ( DATA => X"02", VALID => '1', ERROR => '0'),
        2      => ( DATA => X"03", VALID => '1', ERROR => '0'),
        3      => ( DATA => X"04", VALID => '1', ERROR => '0'),
        4      => ( DATA => X"05", VALID => '1', ERROR => '0'),
        5      => ( DATA => X"06", VALID => '1', ERROR => '0'),
        6      => ( DATA => X"5A", VALID => '1', ERROR => '0'), -- Source Address (5A)
        7      => ( DATA => X"02", VALID => '1', ERROR => '0'),
        8      => ( DATA => X"03", VALID => '1', ERROR => '0'),
        9      => ( DATA => X"04", VALID => '1', ERROR => '0'),
       10      => ( DATA => X"05", VALID => '1', ERROR => '0'),
       11      => ( DATA => X"06", VALID => '1', ERROR => '0'),
       12      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       13      => ( DATA => X"2E", VALID => '1', ERROR => '0'), -- Length/Type = Length = 46
       14      => ( DATA => X"01", VALID => '1', ERROR => '0'),
       15      => ( DATA => X"02", VALID => '1', ERROR => '0'),
       16      => ( DATA => X"03", VALID => '1', ERROR => '0'),
       17      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       18      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       19      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       20      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       21      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       22      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       23      => ( DATA => X"00", VALID => '1', ERROR => '1'), -- Error asserted
       24      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       25      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       26      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       27      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       28      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       29      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       30      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       31      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       32      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       33      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       34      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       35      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       36      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       37      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       38      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       39      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       40      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       41      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       42      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       43      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       44      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       45      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       46      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       47      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       48      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       49      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       50      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       51      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       52      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       53      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       54      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       55      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       56      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       57      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       58      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       59      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       others  => ( DATA => X"00", VALID => '0', ERROR => '0')),

       -- Error this frame
      bad_frame => true),


   -------------
   -- Frame 3
   -------------
   3          => (
      columns  => (
        0      => ( DATA => X"DA", VALID => '1', ERROR => '0'), -- Destination Address (DA)
        1      => ( DATA => X"02", VALID => '1', ERROR => '0'),
        2      => ( DATA => X"03", VALID => '1', ERROR => '0'),
        3      => ( DATA => X"04", VALID => '1', ERROR => '0'),
        4      => ( DATA => X"05", VALID => '1', ERROR => '0'),
        5      => ( DATA => X"06", VALID => '1', ERROR => '0'),
        6      => ( DATA => X"5A", VALID => '1', ERROR => '0'), -- Source Address (5A)
        7      => ( DATA => X"02", VALID => '1', ERROR => '0'),
        8      => ( DATA => X"03", VALID => '1', ERROR => '0'),
        9      => ( DATA => X"04", VALID => '1', ERROR => '0'),
       10      => ( DATA => X"05", VALID => '1', ERROR => '0'),
       11      => ( DATA => X"06", VALID => '1', ERROR => '0'),
       12      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       13      => ( DATA => X"03", VALID => '1', ERROR => '0'), -- Length/Type = Length = 03
       14      => ( DATA => X"01", VALID => '1', ERROR => '0'), -- Therefore padding is required
       15      => ( DATA => X"02", VALID => '1', ERROR => '0'),
       16      => ( DATA => X"03", VALID => '1', ERROR => '0'),
       17      => ( DATA => X"00", VALID => '1', ERROR => '0'), -- Padding starts here
       18      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       19      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       20      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       21      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       22      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       23      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       24      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       25      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       26      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       27      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       28      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       29      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       30      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       31      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       32      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       33      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       34      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       35      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       36      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       37      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       38      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       39      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       40      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       41      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       42      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       43      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       44      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       45      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       46      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       47      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       48      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       49      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       50      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       51      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       52      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       53      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       54      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       55      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       56      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       57      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       58      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       59      => ( DATA => X"00", VALID => '1', ERROR => '0'),
       others  => ( DATA => X"00", VALID => '0', ERROR => '0')),

      -- No error in this frame
      bad_frame => false));


  ------------------------------------------------------------------------------
  -- CRC engine
  ------------------------------------------------------------------------------
  function calc_crc (data : in std_logic_vector;
                     fcs  : in std_logic_vector)
  return std_logic_vector is

    variable crc          : std_logic_vector(31 downto 0);
    variable crc_feedback : std_logic;
  begin

    crc := not fcs;

    for I in 0 to 7 loop
      crc_feedback      := crc(0) xor data(I);

      crc(4 downto 0)   := crc(5 downto 1);
      crc(5)            := crc(6)  xor crc_feedback;
      crc(7 downto 6)   := crc(8 downto 7);
      crc(8)            := crc(9)  xor crc_feedback;
      crc(9)            := crc(10) xor crc_feedback;
      crc(14 downto 10) := crc(15 downto 11);
      crc(15)           := crc(16) xor crc_feedback;
      crc(18 downto 16) := crc(19 downto 17);
      crc(19)           := crc(20) xor crc_feedback;
      crc(20)           := crc(21) xor crc_feedback;
      crc(21)           := crc(22) xor crc_feedback;
      crc(22)           := crc(23);
      crc(23)           := crc(24) xor crc_feedback;
      crc(24)           := crc(25) xor crc_feedback;
      crc(25)           := crc(26);
      crc(26)           := crc(27) xor crc_feedback;
      crc(27)           := crc(28) xor crc_feedback;
      crc(28)           := crc(29);
      crc(29)           := crc(30) xor crc_feedback;
      crc(30)           := crc(31) xor crc_feedback;
      crc(31)           :=             crc_feedback;
    end loop;

    -- return the CRC result
    return not crc;
  end calc_crc;


  ------------------------------------------------------------------------------
  -- Test Bench signals and constants
  ------------------------------------------------------------------------------

  -- Delay to provide setup and hold timing at the GMII/RGMII.
  constant dly : time := 5.8 ns; 
  -- testbench signals
  signal reset                : std_logic                     := '1';             -- start in reset
  signal tx_clk               : std_logic;
  signal tx_statistics_vector : std_logic;
  signal tx_statistics_valid  : std_logic;
  signal rx_clk               : std_logic;
  signal rx_statistics_vector : std_logic;
  signal rx_statistics_valid  : std_logic;
  signal pause_val            : std_logic                     := '0';
  signal pause_req            : std_logic                     := '0';
  signal host_clk             : std_logic                     := '0';
  signal host_opcode          : std_logic_vector(1 downto 0)  := (others => '1');
  signal host_addr            : std_logic_vector(9 downto 0)  := (others => '1');
  signal host_wr_data         : std_logic_vector(31 downto 0) := (others => '0');
  signal host_rd_data         : std_logic_vector(31 downto 0);
  signal host_miim_sel        : std_logic                     := '0';
  signal host_req             : std_logic                     := '0';
  signal host_miim_rdy        : std_logic;
  signal mdc                  : std_logic;
  signal mdio                 : std_logic;
  signal mdio_count           : unsigned(5 downto 0);
  signal last_mdio            : std_logic;
  signal mdio_read            : std_logic;
  signal mdio_addr            : std_logic;
  signal mdio_fail            : std_logic;
  signal mii_tx_en            : std_logic;
  signal mii_tx_er            : std_logic;
  signal mii_txd              : std_logic_vector(3 downto 0) := (others => '0');
  signal mii_rx_clk           : std_logic;
  signal mii_rx_dv            : std_logic := '0';
  signal mii_rx_er            : std_logic := '0';
  signal mii_rxd              : std_logic_vector(3 downto 0) := (others => '0');
  signal mii_tx_clk           : std_logic := '0';
  signal mii_tx_clk100        : std_logic := '0';
  signal mii_tx_clk10         : std_logic := '0';

  -- testbench control signals
  signal current_speed              : std_logic_vector(1 downto 0) := "10";
  signal tx_monitor_finished_10M    : boolean := false;
  signal tx_monitor_finished_100M   : boolean := false;
  signal management_config_finished : boolean := false;
  signal rx_stimulus_finished       : boolean := false;

  signal test_half_duplex           : std_logic := '0';


begin


  ------------------------------------------------------------------------------
  -- Wire up Device Under Test
  ------------------------------------------------------------------------------
  dut: ethernet_example_design
    port map (
      -- asynchronous reset
      reset                => reset,

      -- Client Receiver Statistics Interface (serialised to reduce IO for the example design)
      rx_clk               => rx_clk,
      rx_statistics_vector => rx_statistics_vector,
      rx_statistics_valid  => rx_statistics_valid,

      -- Client Transmitter Statistics Interface (serialised to reduce IO for the example design)
      tx_clk               => tx_clk,
      tx_statistics_vector => tx_statistics_vector,
      tx_statistics_valid  => tx_statistics_valid,

      -- Flow Control (serialised to reduce IO for the example design)
      pause_req            => pause_req,
      pause_val            => pause_val,

      -- MII Interface
      mii_txd              => mii_txd,
      mii_tx_en            => mii_tx_en,
      mii_tx_er            => mii_tx_er,
      mii_rxd              => mii_rxd,
      mii_rx_dv            => mii_rx_dv,
      mii_rx_er            => mii_rx_er,
      mii_rx_clk           => mii_rx_clk,
      mii_tx_clk           => mii_tx_clk,

      -- MDIO Interface
      mdc                  => mdc,
      mdio                 => mdio,

      -- Host Interface
      host_clk             => host_clk,
      host_opcode          => host_opcode,
      host_addr            => host_addr,
      host_wr_data         => host_wr_data,
      host_rd_data         => host_rd_data,
      host_miim_sel        => host_miim_sel,
      host_req             => host_req,
      host_miim_rdy        => host_miim_rdy
    );


  ------------------------------------------------------------------------------
  -- If the simulation is still going after 500 us
  -- then something has gone wrong: terminate with an error
  ------------------------------------------------------------------------------
  p_timebomb : process
  begin
    wait for 550 us;
    assert false
      report "ERROR - Simulation running forever!"
      severity failure;
  end process p_timebomb;


  ------------------------------------------------------------------------------
  -- Simulate the MDIO
  ------------------------------------------------------------------------------
  -- count through the mdio transfer
  p_mdio_count : process (mdc, reset)
  begin
     if (reset = '1') then
        mdio_count <= (others => '0');
        last_mdio <= '0';
     elsif mdc'event and mdc = '1' then
        last_mdio <= mdio;
        if mdio_count >= "100000" then
           mdio_count <= (others => '0');
        elsif (mdio_count /= "000000") then
           mdio_count <= mdio_count + "000001";
        else  -- only get here if mdio state is 0 - now look for a start
           if mdio = '1' and last_mdio = '0' then
              mdio_count <= "000001";
           end if;
        end if; 
     end if; 
  end process p_mdio_count;
  
  mdio <= '1' when (mdio_read = '1' and (mdio_count >= "001110") and (mdio_count <= "011111")) else 'Z';
  
  -- only respond to phy and reg address == 0
  p_mdio_check : process (mdc, reset)
  begin
     if (reset = '1') then
        mdio_read <= '0';  
        mdio_addr <= '1'; -- this will go low if the address doesn't match required   
        mdio_fail <= '0';
     elsif mdc'event and mdc = '1' then
        if (mdio_count = "000010") then
           mdio_addr <= '1';  -- reset at the start of a new access to enable the address to be revalidated
           if last_mdio = '1' and mdio = '0' then
              mdio_read <= '1';
           else -- take a write as a default as won't drive at the wrong time
              mdio_read <= '0';
           end if;
        elsif mdio_count <= "001100" then
           -- check the phy_addr is 7 and the reg_addr is 0
           if mdio_count <= "000111" and mdio_count >= "000101" then
              if (mdio /= '1') then
                 mdio_addr <= '0';
              end if;
           else
              if (mdio /= '0') then
                 mdio_addr <= '0';
              end if;
           end if;
        elsif mdio_count = "001110" then
           if mdio_read = '0' and (mdio = '1' or last_mdio = '0') then
              assert false
                report "ERROR -  Write TA phase is incorrect" & cr
                severity failure;
           end if;
        elsif (mdio_count >= "001111") and (mdio_count <= "011110") and mdio_addr = '1' then
           if (mdio_read = '0') then
              if (mdio_count = "010100") then
                 if (mdio = '1') then
                    mdio_fail <= '1';
                    assert false
                      report "ERROR -  Expected bit 10 of mdio write data to be 0" & cr
                      severity failure;
                 end if;
              else
                 if (mdio = '0') then
                    mdio_fail <= '1';
                    assert false
                      report "ERROR -  Expected all except bit 10 of mdio write data to be 1" & cr
                      severity failure;
                 end if;
              end if;
           end if;
        end if;
     end if;    
  end process p_mdio_check;


  ------------------------------------------------------------------------------
  -- Clock drivers
  ------------------------------------------------------------------------------

  -- drives host_clk at one third the frequency of gtx_clk
  p_host_clk : process
  begin
    host_clk <= '0';
    wait for 2 ns;
    loop
      wait for 12 ns;
      host_clk <= '1';
      wait for 12 ns;
      host_clk <= '0';
    end loop;
  end process p_host_clk;


  -- drives mii_tx_clk100 at 25 MHz
  p_mii_tx_clk100 : process
  begin
    mii_tx_clk100 <= '0';
    wait for 20 ns;
    loop
      wait for 20 ns;
      mii_tx_clk100 <= '1';
      wait for 20 ns;
      mii_tx_clk100 <= '0';
    end loop;
  end process p_mii_tx_clk100;


  -- drives mii_tx_clk10 at 2.5 MHz
  p_mii_tx_clk10 : process
  begin
    mii_tx_clk10 <= '0';
    wait for 10 ns;
    loop
      wait for 200 ns;
      mii_tx_clk10 <= '1';
      wait for 200 ns;
      mii_tx_clk10 <= '0';
    end loop;
  end process p_mii_tx_clk10;


  -- Select between 10Mb/s and 100Mb/s MII Tx clock frequencies
  p_mii_tx_clk : process(current_speed, mii_tx_clk100, mii_tx_clk10)
  begin
    if current_speed = "11" then
      mii_tx_clk <= '0';
    elsif current_speed = "01" then
      mii_tx_clk <= mii_tx_clk100;
    else
      mii_tx_clk <= mii_tx_clk10;
    end if;
  end process p_mii_tx_clk;


  -- Receiver and transmitter clocks are the same in this simulation
  mii_rx_clk <= mii_tx_clk;


  -----------------------------------------------------------------------------
  -- Management process. This process sets up the configuration by
  -- turning off flow control, and checks gathered statistics at the
  -- end of transmission
  -----------------------------------------------------------------------------
  p_management : process

    ------------------------------
    -- Procedure to reset the MAC
    ------------------------------
    procedure mac_reset is
    begin
      assert false
        report "Resetting core..." & cr
        severity note;

      reset <= '1';
      wait for 400 ns;

      reset <= '0';
      wait for 1000 ns;

      wait for 100 ns;
      
      assert false
        report "Timing checks are valid" & cr
        severity note;
    end procedure mac_reset;


    variable rd_data_value  : std_logic_vector(31 downto 0);

    ---------------------------------------------------
    -- Procedure to perform a Host Configuration Write
    ---------------------------------------------------
    procedure host_write(reg_address: in std_logic_vector(8 downto 0);
                         wr_data    : in std_logic_vector(31 downto 0)) is
    begin
      wait until host_clk'event and host_clk = '0';
      host_addr(9)          <= '1';
      host_addr(8 downto 0) <= reg_address;
      host_miim_sel         <= '0';
      host_opcode           <= "01";
      host_wr_data          <= wr_data;
      wait until host_clk'event and host_clk = '0';
      host_addr(9)          <= '0';
      host_addr(8 downto 0) <= (others => '0');
      host_miim_sel         <= '1';
      host_opcode           <= "11";
      host_wr_data          <= (others => '0');
    end procedure host_write;


    --------------------------------------------------
    -- Procedure to perform a Host Configuration Read
    -- An extra cycle is required as the example design 
    -- has an extra pipeline delay
    --------------------------------------------------
    procedure host_read(reg_address: in std_logic_vector(8 downto 0);
                        rd_data    : out std_logic_vector(31 downto 0)) is
    begin
      wait until host_clk'event and host_clk = '0';
      host_addr(9)          <= '1';
      host_addr(8 downto 0) <= reg_address;
      host_miim_sel         <= '0';
      host_opcode           <= "11";
      wait until host_clk'event and host_clk = '0';
      host_addr(9)          <= '0';
      host_addr(8 downto 0) <= (others => '0');
      host_miim_sel         <= '1';
      host_opcode           <= "11";
      wait until host_clk'event and host_clk = '0';
      wait until host_clk'event and host_clk = '1';
      rd_data               := host_rd_data;
    end procedure host_read;

    ---------------------------------------------------
    -- Procedure to perform an MDIO Configuration Write
    ---------------------------------------------------
    procedure p_mdio_write(phy_addr: in std_logic_vector(4 downto 0);
                         reg_addr  : in std_logic_vector(4 downto 0);
                         wr_data   : in std_logic_vector(15 downto 0)) is
    begin
      wait until host_clk'event and host_clk = '0';
      host_addr(9 downto 0) <= phy_addr & reg_addr;
      host_miim_sel         <= '1';
      host_opcode           <= "01";
      host_req              <= '1';
      host_wr_data          <= X"0000" & wr_data;
      wait until host_clk'event and host_clk = '0';
      host_addr(9 downto 0) <= (others => '0');
      host_miim_sel         <= '1';
      host_opcode           <= "11";
      host_req              <= '0';
      host_wr_data          <= (others => '0');
      wait until host_clk'event and host_clk = '0';
      wait until host_miim_rdy'event and host_miim_rdy = '1';
    end procedure p_mdio_write;


    --------------------------------------------------
    -- Procedure to perform an MDIO Configuration Read
    -- An extra cycle is required as the example design 
    -- has an extra pipeline delay
    --------------------------------------------------
    procedure p_mdio_read(phy_addr: in std_logic_vector(4 downto 0);
                        reg_addr  : in std_logic_vector(4 downto 0);
                        rd_data   : out std_logic_vector(31 downto 0)) is
    begin
      wait until host_clk'event and host_clk = '0';
      host_addr(9 downto 0) <= phy_addr & reg_addr;
      host_miim_sel         <= '1';
      host_opcode           <= "10";
      host_req              <= '1';
      wait until host_clk'event and host_clk = '0';
      host_addr(9 downto 0) <= (others => '0');
      host_miim_sel         <= '1';
      host_opcode           <= "11";
      host_req              <= '0';
      wait until host_clk'event and host_clk = '0';
      wait until host_miim_rdy'event and host_miim_rdy = '1';
      wait until host_clk'event and host_clk = '0';
      wait until host_clk'event and host_clk = '1';
      rd_data               := host_rd_data;
    end procedure p_mdio_read;

    procedure configure_mac is
    begin
      --------------------------------------------------------------------
      -- Configure the MAC though the Management I/F.
      --------------------------------------------------------------------
      -- add a delay to ensure the mdio logic is out of reset
      wait for 150 ns;

      -- set up MDC frequency. Write 2E to Management configuration
      -- register (Add=340). This will enable MDIO and set MDC to 2.083MHz
      -- (set CLOCK_DIVIDE value to 9 dec. for 41.66MHz host_clk and
      -- enable mdio)
      assert false
        report "Setting MDC Frequency to 2.3MHZ...." & cr
        severity note;
      host_write(config_management_add, x"00000049");

      -- Reading Management Configuration Register (Add=340).
      assert false
        report "Reading Management Configuration  Register...." & cr
        severity note;
      host_read(config_management_add, rd_data_value);
      
      -- confirm the write took place - i.e not still in reset
      while rd_data_value /= x"00000049" loop
        assert false
          report "Retrying host access." & cr
          severity note;
      
        host_write(config_management_add, x"00000049");
        host_read(config_management_add, rd_data_value);
      end loop;

      -- Disable Flow Control. Set top 3 bits of the flow control
      -- configuration register (Add=2C0) to zero therefore disabling tx
      -- and rx flow control.
      assert false
        report "Disabling tx and rx flow control..." & cr
        severity note;
      host_write(config_flow_ctrl_add, x"00000000");


      -- Reading Flow Control Configuration Register (Add=2C0).
      assert false
        report "Reading Flow Control Configuration  Register...." & cr
        severity note;
      host_read(config_flow_ctrl_add, rd_data_value);

      wait until host_clk'event and host_clk = '0';

      if test_half_duplex = '1' then
        assert false
          report "Putting device into half duplex mode...." & cr
          severity note;
        host_write(transmitter_add, x"14000000");
        host_write(receiver_add,    x"14000000");
      end if;

        -- Write MAC Unicast address to value DA-02-03-04-05-06 using host i/f.
      -- The Unicast Address is stored in configuration registers Add=0x380
      -- and Add=0x384.

      assert false
        report "Writing Unicast Address bits 31:0..." & cr
        severity note;
      -- Write lower bits of unicast address
      host_write(config_uni0_ctrl_add, x"040302DA");

      assert false
        report "Writing Unicast Address bits 47:32..." & cr
        severity note;
      host_write(config_uni1_ctrl_add, x"00000605");

      -- Set Address Filter to operate in Enabled Mode. Set top bit of
      -- the address filter configuration register (Add=390) to
      -- zero.
      assert false
        report "Setting Address Filter to Enabled Mode..." & cr
        severity note;
      host_write(config_addr_ctrl_add,   x"00000000");

      -- Reading Address Filter Configuration  Register (Add=390).
      assert false
        report "Reading Address Filter Configuration  Register...." & cr
        severity note;
      host_read(config_addr_ctrl_add, rd_data_value);

      end procedure configure_mac;


  begin  -- process p_management

  assert false
      report "Timing checks are not valid" & cr
      severity note;

    --------------------------------------------------------------------
    -- Change the speed to 100Mb/s and send the 4 frames
    --------------------------------------------------------------------

    assert false
      report "Timing checks are not valid" & cr
      severity note;

    assert false
      report "Setting speed to 100Mb/s...." & cr
      severity note;
    host_write(emac_config_add, "01000000000000000000000000000000");

    current_speed <= "01";


    -- A reset is required after any speed change
    wait for 100 ns;
    mac_reset;
    --------------------------------------------------------------------
    -- Configure the MAC though the Management I/F.
    --------------------------------------------------------------------
    configure_mac;
    -- Signal that configuration is complete.  Other processes will now
    -- be allowed to run.
    management_config_finished <= true;


    -- Wait for 100M monitor process to complete.
    wait until tx_monitor_finished_100M;
    management_config_finished <= false;

    --------------------------------------------------------------------
    -- Change the speed to 10Mb/s and send the 4 frames
    --------------------------------------------------------------------

    assert false
      report "Timing checks are not valid" & cr
      severity note;

    assert false
      report "Setting speed to 10Mb/s...." & cr
      severity note;
    host_write(emac_config_add, "00000000000000000000000000000000");
    -- cleanly switch the mii clock wait for mii to go low and set clock 
    -- to low setting until mii_10 is low
    wait until mii_tx_clk'event and mii_tx_clk = '0';
    current_speed <= "11";
    wait until mii_tx_clk10'event and mii_tx_clk10 = '0';
    current_speed <= "00";

    -- A reset is required after any speed change
    wait for 1000 ns;
    mac_reset;
    --------------------------------------------------------------------
    -- Configure the MAC though the Management I/F.
    --------------------------------------------------------------------
    configure_mac;
    --------------------------------------------------------------------
    -- Perform MDIO reads and writes when running at 10M as this has little 
    -- impact upon simulation time
    -- read write from phy address 7 reg address 0
    -- force bit 10 of the read value to 0
    --------------------------------------------------------------------
    p_mdio_read("00111", "00000",rd_data_value);
    p_mdio_write("00111", "00000",rd_data_value(15 downto 11) & '0' & rd_data_value(9 downto 0));
    -- Signal that configuration is complete.  Other processes will now
    -- be allowed to run.
    management_config_finished <= true;
    

    wait;

  end process p_management;



  ------------------------------------------------------------------------------
  -- Stimulus process. This process will inject frames of data into the
  -- PHY side of the receiver.
  ------------------------------------------------------------------------------
  p_stimulus : process



    ---------------------------------------------------------------
    -- Procedure to inject a frame into the receiver at 10/100Mb/s
    ---------------------------------------------------------------
    procedure send_frame_10_100m (current_frame : in natural) is
      variable current_col   : natural := 0;  -- Column counter within frame
      variable fcs           : std_logic_vector(31 downto 0);
    begin

      wait until mii_rx_clk'event and mii_rx_clk = '1';

      -- Reset the FCS calculation
      fcs         := (others => '0');

      -- Adding the preamble field
      for j in 0 to 15 loop
        mii_rxd   <= "0101" after 30 ns;
        mii_rx_dv <= '1' after 30 ns;
        mii_rx_er <= '0' after 30 ns;
        wait until mii_rx_clk'event and mii_rx_clk = '1';
      end loop;

      -- Adding the Start of Frame Delimiter (SFD)
      mii_rxd   <= "1101" after 30 ns;
      mii_rx_dv <= '1' after 30 ns;
      mii_rx_er <= '0' after 30 ns;
      wait until mii_rx_clk'event and mii_rx_clk = '1';

      current_col := 0;
      mii_rxd     <= to_stdlogicvector(frame_data(current_frame).columns(current_col).data(3 downto 0)) after 30 ns;
      mii_rx_dv   <= to_stdUlogic(frame_data(current_frame).columns(current_col).valid) after 30 ns;
      mii_rx_er   <= to_stdUlogic(frame_data(current_frame).columns(current_col).error) after 30 ns;

      wait until mii_rx_clk'event and mii_rx_clk = '1';
      mii_rxd     <= to_stdlogicvector(frame_data(current_frame).columns(current_col).data(7 downto 4)) after 30 ns;
      mii_rx_dv   <= to_stdUlogic(frame_data(current_frame).columns(current_col).valid) after 30 ns;
      mii_rx_er   <= to_stdUlogic(frame_data(current_frame).columns(current_col).error) after 30 ns;
      fcs          := calc_crc(to_stdlogicvector(frame_data(current_frame).columns(current_col).data), fcs);

      wait until mii_rx_clk'event and mii_rx_clk = '1';

      current_col := current_col + 1;
      -- loop over columns in frame.
      while frame_data(current_frame).columns(current_col).valid /= '0' loop
        -- send one column of data
        mii_rxd   <= to_stdlogicvector(frame_data(current_frame).columns(current_col).data(3 downto 0)) after 30 ns;
        mii_rx_dv <= to_stdUlogic(frame_data(current_frame).columns(current_col).valid) after 30 ns;
        mii_rx_er <= to_stdUlogic(frame_data(current_frame).columns(current_col).error) after 30 ns;

        wait until mii_rx_clk'event and mii_rx_clk = '1';
        mii_rxd   <= to_stdlogicvector(frame_data(current_frame).columns(current_col).data(7 downto 4)) after 30 ns;
        mii_rx_dv <= to_stdUlogic(frame_data(current_frame).columns(current_col).valid) after 30 ns;
        mii_rx_er <= to_stdUlogic(frame_data(current_frame).columns(current_col).error) after 30 ns;

        fcs         := calc_crc(to_stdlogicvector(frame_data(current_frame).columns(current_col).data), fcs);
        current_col := current_col + 1;
        wait until mii_rx_clk'event and mii_rx_clk = '1';  -- wait for next clock tick

      end loop;

      -- Send the CRC.
      for j in 0 to 3 loop
         mii_rxd   <= fcs(((8*j)+3) downto (8*j)) after 30 ns;
         mii_rx_dv <= '1' after 30 ns;
         mii_rx_er <= '0' after 30 ns;
         wait until mii_rx_clk'event and mii_rx_clk = '1';  -- wait for next clock tick
         mii_rxd   <= fcs(((8*j)+7) downto ((8*j)+4)) after 30 ns;
         mii_rx_dv <= '1' after 30 ns;
         mii_rx_er <= '0' after 30 ns;
         wait until mii_rx_clk'event and mii_rx_clk = '1';  -- wait for next clock tick
      end loop;

      -- Clear the data lines.
      mii_rxd   <= (others => '0') after 30 ns;
      mii_rx_dv <=  '0' after 30 ns;
      mii_rx_er <=  '0' after 30 ns;

      -- Adding the minimum Interframe gap for a receiver (8 idles)
      for j in 0 to 7 loop
        wait until mii_rx_clk'event and mii_rx_clk = '1';
      end loop;

    end send_frame_10_100m;


  begin


    -------------------------------------------------------
    -- Send four frames through the MAC and Design Exampled
    -- at each state Ethernet speed
    --      -- frame 0 = minimum length frame
    --      -- frame 1 = type frame
    --      -- frame 2 = errored frame
    --      -- frame 3 = padded frame
    -------------------------------------------------------


    -------------------------------------------------------
    -- 100 Mb/s speed
    -------------------------------------------------------
    -- Wait for the Management MDIO transaction to finish.
    wait until management_config_finished;
    assert false
      report "Sending four frames at 100Mb/s..." & cr
      severity note;

    for current_frame in frame_data'low to frame_data'high loop
      send_frame_10_100m(current_frame);
    end loop;

    -- Wait for 100M monitor process to complete.
    wait until tx_monitor_finished_100M;

    wait for 100 ns;

    -------------------------------------------------------
    -- 10 Mb/s speed
    -------------------------------------------------------
    -- Wait for the Management MDIO transaction to finish.
    wait until management_config_finished;
    assert false
      report "Sending four frames at 10Mb/s..." & cr
      severity note;

    for current_frame in frame_data'low to frame_data'high loop
      send_frame_10_100m(current_frame);
    end loop;

    -- Wait for 100M monitor process to complete.
    wait until tx_monitor_finished_10M;

    rx_stimulus_finished <= true;

    -- Our work here is done
    assert false
      report "Simulation stopped"
      severity failure;
  end process p_stimulus;



  ------------------------------------------------------------------------------
  -- Monitor process. This process checks the data coming out of the
  -- transmitter to make sure that it matches that inserted into the
  -- receiver.
  ------------------------------------------------------------------------------
  p_monitor : process



    --------------------------------------------------------
    -- Procedure to check a transmitted frame at 10/100Mb/s
    --------------------------------------------------------
    procedure check_frame_10_100m (current_frame : in natural) is
      variable current_col   : natural := 0;  -- Column counter within frame
      variable fcs           : std_logic_vector(31 downto 0);
    begin

      -- Reset the FCS calculation
      fcs         := (others => '0');

      -- Parse over the preamble field
      while mii_tx_en /= '1' or mii_txd = "0101" loop
        wait until mii_tx_clk'event and mii_tx_clk = '1';
      end loop;

      -- Start comparing transmitted dat to received data
      assert false
        report "Comparing Transmitted Data Frames to Received Data Frames" & cr
        severity note;

      -- Parse over the Start of Frame Delimiter (SFD)
      if (mii_txd /= "1101") then
        assert false
          report "SFD not present" & cr
          severity error;
      end if;
      wait until mii_tx_clk'event and mii_tx_clk = '1';

      -- frame has started, loop over columns of frame
      while ((frame_data(current_frame).columns(current_col).valid)='1') loop

          assert (mii_tx_en = to_stdulogic(frame_data(current_frame).columns(current_col).valid))
            report "mii_tx_en incorrect" & cr
            severity error;

          if mii_tx_en = '1' then

            -- The transmitted Destination Address was the Source Address of the injected frame
            if current_col < 6 then
              fcs := calc_crc(to_stdlogicvector(frame_data(current_frame).columns(current_col+6).data), fcs);
              assert (mii_txd =
                    to_stdlogicvector(frame_data(current_frame).columns(current_col+6).data(3 downto 0)))
                report "mii_txd incorrect" & cr
                severity error;
              wait until mii_tx_clk'event and mii_tx_clk = '1';
              assert (mii_txd =
                    to_stdlogicvector(frame_data(current_frame).columns(current_col+6).data(7 downto 4)))
                report "mii_txd incorrect" & cr
                severity error;

            -- The transmitted Source Address was the Destination Address of the injected frame
            elsif current_col >= 6 and current_col < 12 then
              fcs := calc_crc(to_stdlogicvector(frame_data(current_frame).columns(current_col-6).data), fcs);
              assert (mii_txd =
                    to_stdlogicvector(frame_data(current_frame).columns(current_col-6).data(3 downto 0)))
                report "mii_txd incorrect" & cr
                severity error;
              wait until mii_tx_clk'event and mii_tx_clk = '1';
              assert (mii_txd =
                    to_stdlogicvector(frame_data(current_frame).columns(current_col-6).data(7 downto 4)))
                report "mii_txd incorrect" & cr
                severity error;

            -- for remainder of frame
            else
              fcs := calc_crc(to_stdlogicvector(frame_data(current_frame).columns(current_col).data), fcs);
              assert (mii_txd =
                    to_stdlogicvector(frame_data(current_frame).columns(current_col).data(3 downto 0)))
                report "mii_txd incorrect" & cr
                severity error;
              wait until mii_tx_clk'event and mii_tx_clk = '1';
              assert (mii_txd =
                    to_stdlogicvector(frame_data(current_frame).columns(current_col).data(7 downto 4)))
                report "mii_txd incorrect" & cr
                severity error;
            end if;
        end if;

        -- calculate expected crc for the frame
        --fcs        := calc_crc(mii_txd, fcs);

        -- wait for next column of data
        current_col        := current_col + 1;
        wait until mii_tx_clk'event and mii_tx_clk = '1';
      end loop;  -- while data valid

      -- Check the FCS matches that expected from calculation
      -- Having checked all data columns, txd must contain FCS.
      for j in 0 to 3 loop
        assert (mii_tx_en = '1')
          report "mii_tx_en incorrect during FCS field"  & cr
          severity error;

        assert (mii_txd = fcs(((8*j)+3) downto (8*j)))
          report "mii_txd incorrect during FCS field"  & cr
          severity error;

        wait until mii_tx_clk'event and mii_tx_clk = '1';

        assert (mii_tx_en = '1')
          report "mii_tx_en incorrect during FCS field"  & cr
          severity error;

        assert (mii_txd = fcs(((8*j)+7) downto ((8*j)+4)))
          report "mii_txd incorrect during FCS field"  & cr
          severity error;

        wait until mii_tx_clk'event and mii_tx_clk = '1';
      end loop;  -- j

    end check_frame_10_100m;


    variable f                  : frame_typ;       -- temporary frame variable
    variable current_frame      : natural   := 0;  -- current frame pointer


  begin  -- process p_monitor


    -------------------------------------------------------
    -- Compare the transmitted frame to the received frames
    --      -- frame 0 = minimum length frame
    --      -- frame 1 = type frame
    --      -- frame 2 = errored frame
    --      -- frame 3 = padded frame
    -- Repeated for all stated speeds.
    -------------------------------------------------------

    -- wait for reset to complete before starting monitor to ignore false startup errors
    wait until reset'event and reset = '0';

    -------------------------------------------------------
    -- 100 Mb/s speed
    -------------------------------------------------------

    current_frame      := 0;

    -- Look for 100Mb/s frames.
    -- loop over all the frames in the stimulus vector
    loop

      -- If the current frame had an error inserted then it would have been
      -- dropped by the FIFO in the design example.  Therefore move immediately
      -- on to the next frame.
      while frame_data(current_frame).bad_frame loop
        current_frame := current_frame + 1;
      if current_frame = frame_data'high + 1 then
          exit;
        end if;
      end loop;

      -- There are only 4 frames in this test.
      if current_frame = frame_data'high + 1 then
        exit;
      end if;

      -- Check the current frame
      check_frame_10_100m(current_frame);

      -- move to the next frame
      if current_frame = frame_data'high then
        exit;
      else
        current_frame := current_frame + 1;
      end if;

    end loop;
    wait for 200 ns;
    tx_monitor_finished_100M <= true;

    -------------------------------------------------------
    -- 10 Mb/s speed
    -------------------------------------------------------

    current_frame      := 0;

    -- Look for 10Mb/s frames.
    -- loop over all the frames in the stimulus vector
    loop

      -- If the current frame had an error inserted then it would have been
      -- dropped by the FIFO in the design example.  Therefore move immediately
      -- on to the next frame.
      while frame_data(current_frame).bad_frame loop
        current_frame := current_frame + 1;
        if current_frame = frame_data'high + 1 then
          exit;
        end if;
      end loop;

      -- There are only 4 frames in this test.
      if current_frame = frame_data'high + 1 then
        exit;
      end if;

      -- Check the current frame
      check_frame_10_100m(current_frame);

      -- move to the next frame
      if current_frame = frame_data'high then
        exit;
      else
        current_frame := current_frame + 1;
      end if;

    end loop;
    wait for 200 ns;
    tx_monitor_finished_10M <= true;


    wait;
  end process p_monitor;



end behav;

