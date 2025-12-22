library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity led_driver is
    Port (
        i_rx_clock    : in  STD_LOGIC;
        i_rx_reset    : in  STD_LOGIC;
        
        i_rx_frame    : in  STD_LOGIC;
        
        i_switch      : in  STD_LOGIC_VECTOR(3 downto 0);
        
        o_led         : out STD_LOGIC_VECTOR(7 downto 0)
    );
end led_driver;

architecture Behavioral of led_driver is
    
    signal s_rx_activity : std_logic := '0';
    signal s_rx_timeout  : integer range 0 to 50000000 := 0;
    
begin
    
    process(i_rx_clock)
    begin
        if rising_edge(i_rx_clock) then
            if i_rx_reset = '1' then
                s_rx_activity <= '0';
                s_rx_timeout <= 0;
            else
                if i_rx_frame = '1' then
                    s_rx_activity <= '1';
                    s_rx_timeout <= 50000000;  
                elsif s_rx_timeout > 0 then
                    s_rx_timeout <= s_rx_timeout - 1;
                else
                    s_rx_activity <= '0';
                end if;
            end if;
        end if;
    end process;
    
    o_led(7)          <= s_rx_activity;  
    o_led(6 downto 4) <= "000";          
    o_led(3 downto 0) <= i_switch;       

end Behavioral;

