----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:32:54 12/13/2025 
-- Design Name: 
-- Module Name:    mlp - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mlp is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_data : in std_logic_vector(7 downto 0);
        o_data : out std_logic_vector(7 downto 0)
    );
end mlp;

architecture Behavioral of mlp is

begin


end Behavioral;

