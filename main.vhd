----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:33:37 11/29/2025 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    port (
        i_clk_50mhz : in std_logic;
        i_reset_n : in std_logic;

        -- Switch Inputs (4-bit value)
        SW : in std_logic_vector(3 downto 0);

        -- LED Outputs
        LED : out std_logic_vector(7 downto 0);
        -- PHY Reset Pin
        o_phy_reset_n : out std_logic;

        -- ethernet top signals
        -- MII Interface (PHY pins)
        MII_RX_CLK : in std_logic;
        MII_RXD : in std_logic_vector (3 downto 0);
        MII_RX_DV : in std_logic;
        MII_RX_ER : in std_logic;
        -- MII_CRS and MII_COL not used (full-duplex mode)
        MII_TX_CLK : in std_logic;
        MII_TXD : out std_logic_vector (3 downto 0);
        MII_TX_EN : out std_logic;

        -- MDIO Management Interface
        MDC : out std_logic;
        MDIO : inout std_logic
    );
end main;

architecture Behavioral of main is
    component ethernet_top is
        port (
            i_clk_50mhz   : in  STD_LOGIC;
            i_reset_n     : in  STD_LOGIC;
    
            MII_RX_CLK    : in  STD_LOGIC;
            MII_RXD       : in  STD_LOGIC_VECTOR (3 downto 0);
            MII_RX_DV     : in  STD_LOGIC;
            MII_RX_ER     : in  STD_LOGIC;
            -- MII_CRS and MII_COL not used (full-duplex mode)
            MII_TX_CLK    : in  STD_LOGIC;
            MII_TXD       : out STD_LOGIC_VECTOR (3 downto 0);
            MII_TX_EN     : out STD_LOGIC;
            -- MDIO Management Interface
            MDC           : out STD_LOGIC;
            MDIO          : inout STD_LOGIC;
            -- PHY Reset Pin
            o_phy_reset_n : out std_logic
        );
    end component;

begin
    ethernet_top_inst : component ethernet_top
    port map (
        i_clk_50mhz => i_clk_50mhz,
        i_reset_n => i_reset_n,
        MII_RX_CLK => MII_RX_CLK,
        MII_RXD => MII_RXD,
        MII_RX_DV => MII_RX_DV,
        MII_RX_ER => MII_RX_ER,
        MII_TX_CLK => MII_TX_CLK,
        MII_TXD => MII_TXD,
        MII_TX_EN => MII_TX_EN,
        MDC => MDC,
        MDIO => MDIO,
        o_phy_reset_n => o_phy_reset_n
    );
    
    

end Behavioral;