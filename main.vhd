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
use IEEE.NUMERIC_STD.all;

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

    -- Ethernet Top Component
    component ethernet_top is
        port (
            i_clk_50mhz   : in  STD_LOGIC;
            i_reset_n     : in  STD_LOGIC;
    
            MII_RX_CLK    : in  STD_LOGIC;
            MII_RXD       : in  STD_LOGIC_VECTOR (3 downto 0);
            MII_RX_DV     : in  STD_LOGIC;
            MII_RX_ER     : in  STD_LOGIC;
            MII_TX_CLK    : in  STD_LOGIC;
            MII_TXD       : out STD_LOGIC_VECTOR (3 downto 0);
            MII_TX_EN     : out STD_LOGIC;
            MDC           : out STD_LOGIC;
            MDIO          : inout STD_LOGIC;
            -- PHY Reset Pin
            o_phy_reset_n : out std_logic;
            -- RX Data Interface (for MLP)
            o_rx_clock    : out std_logic;
            o_rx_frame    : out std_logic;
            o_rx_data     : out std_logic_vector(7 downto 0);
            o_rx_valid    : out std_logic;
            o_rx_error    : out std_logic
        );
    end component;

    -- MLP Neural Network Component
    component mlp is
        port (
            i_clk           : in  std_logic;
            i_reset         : in  std_logic;
            i_start         : in  std_logic;
            o_done          : out std_logic;
            o_busy          : out std_logic;
            i_input_wr_en   : in  std_logic;
            i_input_addr    : in  unsigned(5 downto 0);
            i_input_data    : in  signed(15 downto 0);
            o_class_result  : out unsigned(1 downto 0);
            o_led           : out std_logic_vector(2 downto 0)
        );
    end component;

    -- Internal signals
    signal reset : std_logic;
    
    -- MLP signals
    signal mlp_start        : std_logic := '0';
    signal mlp_done         : std_logic;
    signal mlp_busy         : std_logic;
    signal mlp_input_wr_en  : std_logic := '0';
    signal mlp_input_addr   : unsigned(5 downto 0) := (others => '0');
    signal mlp_input_data   : signed(15 downto 0) := (others => '0');
    signal mlp_class_result : unsigned(1 downto 0);
    signal mlp_led          : std_logic_vector(2 downto 0);
    
    -- Ethernet RX signals
    signal eth_rx_clock     : std_logic;
    signal eth_rx_frame     : std_logic;
    signal eth_rx_data      : std_logic_vector(7 downto 0);
    signal eth_rx_valid     : std_logic;
    signal eth_rx_error     : std_logic;
    
    -- Data pipeline state machine
    type pipeline_state_t is (IDLE, SKIP_HEADER, COLLECT_DATA, START_MLP, WAIT_MLP);
    signal pipeline_state   : pipeline_state_t := IDLE;
    signal byte_counter     : unsigned(7 downto 0) := (others => '0');
    signal data_index       : unsigned(5 downto 0) := (others => '0');
    signal prev_rx_frame    : std_logic := '0';
    
    -- Debug signals
    signal frame_count      : unsigned(3 downto 0) := (others => '0');

begin

    -- Reset is active high internally
    reset <= not i_reset_n;

    -- Ethernet Top Instance
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
        o_phy_reset_n => o_phy_reset_n,
        o_rx_clock => eth_rx_clock,
        o_rx_frame => eth_rx_frame,
        o_rx_data => eth_rx_data,
        o_rx_valid => eth_rx_valid,
        o_rx_error => eth_rx_error
    );

    -- MLP Neural Network Instance
    mlp_inst : component mlp
    port map (
        i_clk           => i_clk_50mhz,
        i_reset         => reset,
        i_start         => mlp_start,
        o_done          => mlp_done,
        o_busy          => mlp_busy,
        i_input_wr_en   => mlp_input_wr_en,
        i_input_addr    => mlp_input_addr,
        i_input_data    => mlp_input_data,
        o_class_result  => mlp_class_result,
        o_led           => mlp_led
    );


    LED(0) <= mlp_led(0);
    LED(1) <= mlp_led(1);
    LED(2) <= mlp_led(2);
    LED(3) <= mlp_busy;
    LED(4) <= mlp_done;
    LED(5) <= frame_count(0);
    LED(6) <= eth_rx_frame;
    LED(7) <= '1' when pipeline_state /= IDLE else '0';

    process(i_clk_50mhz)
    begin
        if rising_edge(i_clk_50mhz) then
            if reset = '1' then
                pipeline_state <= IDLE;
                byte_counter <= (others => '0');
                data_index <= (others => '0');
                mlp_start <= '0';
                mlp_input_wr_en <= '0';
                prev_rx_frame <= '0';
                frame_count <= (others => '0');
            else
                prev_rx_frame <= eth_rx_frame;
                mlp_start <= '0';
                mlp_input_wr_en <= '0';
                
                if eth_rx_frame = '1' and prev_rx_frame = '0' then
                    frame_count <= frame_count + 1;
                end if;
                
                case pipeline_state is
                    when IDLE =>
                        if eth_rx_frame = '1' and prev_rx_frame = '0' then
                            pipeline_state <= SKIP_HEADER;
                            byte_counter <= (others => '0');
                            data_index <= (others => '0');
                        end if;
                        
                    when SKIP_HEADER =>
                        if eth_rx_valid = '1' then
                            byte_counter <= byte_counter + 1;
                            if byte_counter = 13 then
                                pipeline_state <= COLLECT_DATA;
                                byte_counter <= (others => '0');
                            end if;
                        end if;
                        if eth_rx_frame = '0' then
                            pipeline_state <= IDLE;
                        end if;
                        
                    when COLLECT_DATA =>
                        if eth_rx_valid = '1' then
                            if data_index < 40 then
                                mlp_input_data <= signed(eth_rx_data & "00000000");
                                mlp_input_addr <= data_index;
                                mlp_input_wr_en <= '1';
                                data_index <= data_index + 1;
                            end if;
                            if data_index = 39 then
                                pipeline_state <= START_MLP;
                            end if;
                        end if;
                        if eth_rx_frame = '0' then
                            if data_index >= 40 then
                                pipeline_state <= START_MLP;
                            else
                                pipeline_state <= IDLE;
                            end if;
                        end if;
                        
                    when START_MLP =>
                        mlp_start <= '1';
                        pipeline_state <= WAIT_MLP;
                        
                    when WAIT_MLP =>
                        if mlp_done = '1' then
                            pipeline_state <= IDLE;
                        end if;
                        
                    when others =>
                        pipeline_state <= IDLE;
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;