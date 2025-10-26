--------------------------------------------------------------------------------
--     (c) Copyright 1995 - 2010 Xilinx, Inc. All rights reserved.            --
--                                                                            --
--     This file contains confidential and proprietary information            --
--     of Xilinx, Inc. and is protected under U.S. and                        --
--     international copyright and other intellectual property                --
--     laws.                                                                  --
--                                                                            --
--     DISCLAIMER                                                             --
--     This disclaimer is not a license and does not grant any                --
--     rights to the materials distributed herewith. Except as                --
--     otherwise provided in a valid license issued to you by                 --
--     Xilinx, and to the maximum extent permitted by applicable              --
--     law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND                --
--     WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES            --
--     AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING              --
--     BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-                 --
--     INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and               --
--     (2) Xilinx shall not be liable (whether in contract or tort,           --
--     including negligence, or under any other theory of                     --
--     liability) for any loss or damage of any kind or nature                --
--     related to, arising under or in connection with these                  --
--     materials, including for any direct, or any indirect,                  --
--     special, incidental, or consequential loss or damage                   --
--     (including loss of data, profits, goodwill, or any type of             --
--     loss or damage suffered as a result of any action brought              --
--     by a third party) even if such damage or loss was                      --
--     reasonably foreseeable or Xilinx had been advised of the               --
--     possibility of the same.                                               --
--                                                                            --
--     CRITICAL APPLICATIONS                                                  --
--     Xilinx products are not designed or intended to be fail-               --
--     safe, or for use in any application requiring fail-safe                --
--     performance, such as life-support or safety devices or                 --
--     systems, Class III medical devices, nuclear facilities,                --
--     applications related to the deployment of airbags, or any              --
--     other applications that could lead to death, personal                  --
--     injury, or severe property or environmental damage                     --
--     (individually and collectively, "Critical                              --
--     Applications"). Customer assumes the sole risk and                     --
--     liability of any use of Xilinx products in Critical                    --
--     Applications, subject only to applicable laws and                      --
--     regulations governing limitations on product liability.                --
--                                                                            --
--     THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS               --
--     PART OF THIS FILE AT ALL TIMES.                                        --
--------------------------------------------------------------------------------

--  Generated from component ID: xilinx.com:ip:tri_mode_eth_mac:4.6


-- The following code must appear in the VHDL architecture header:

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
component ethernet
	port (
	reset: in std_logic;
	phyemactxenable: in std_logic;
	emacphytxd: out std_logic_vector(3 downto 0);
	emacphytxen: out std_logic;
	emacphytxer: out std_logic;
	phyemacrxd: in std_logic_vector(3 downto 0);
	phyemacrxdv: in std_logic;
	phyemacrxer: in std_logic;
	emacphymclkout: out std_logic;
	emacphymdtri: out std_logic;
	emacphymdout: out std_logic;
	phyemacmdin: in std_logic;
	clientemactxd: in std_logic_vector(7 downto 0);
	clientemactxdvld: in std_logic;
	emacclienttxack: out std_logic;
	clientemactxunderrun: in std_logic;
	clientemactxifgdelay: in std_logic_vector(7 downto 0);
	clientemactxenable: in std_logic;
	clientemacpausereq: in std_logic;
	clientemacpauseval: in std_logic_vector(15 downto 0);
	emacclientrxd: out std_logic_vector(7 downto 0);
	emacclientrxdvld: out std_logic;
	emacclientrxgoodframe: out std_logic;
	emacclientrxbadframe: out std_logic;
	clientemacrxenable: in std_logic;
	emacclienttxstats: out std_logic_vector(31 downto 0);
	emacclienttxstatsvld: out std_logic;
	emacclientrxstats: out std_logic_vector(27 downto 0);
	emacclientrxstatsvld: out std_logic;
	tieemacunicastaddr: in std_logic_vector(47 downto 0);
	txgmiimiiclk: in std_logic;
	rxgmiimiiclk: in std_logic;
	speedis100: out std_logic;
	speedis10100: out std_logic;
	hostclk: in std_logic;
	hostopcode: in std_logic_vector(1 downto 0);
	hostreq: in std_logic;
	hostmiimsel: in std_logic;
	hostaddr: in std_logic_vector(9 downto 0);
	hostwrdata: in std_logic_vector(31 downto 0);
	hostmiimrdy: out std_logic;
	hostrddata: out std_logic_vector(31 downto 0);
	corehassgmii: in std_logic);
end component;

-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : ethernet
		port map (
			reset => reset,
			phyemactxenable => phyemactxenable,
			emacphytxd => emacphytxd,
			emacphytxen => emacphytxen,
			emacphytxer => emacphytxer,
			phyemacrxd => phyemacrxd,
			phyemacrxdv => phyemacrxdv,
			phyemacrxer => phyemacrxer,
			emacphymclkout => emacphymclkout,
			emacphymdtri => emacphymdtri,
			emacphymdout => emacphymdout,
			phyemacmdin => phyemacmdin,
			clientemactxd => clientemactxd,
			clientemactxdvld => clientemactxdvld,
			emacclienttxack => emacclienttxack,
			clientemactxunderrun => clientemactxunderrun,
			clientemactxifgdelay => clientemactxifgdelay,
			clientemactxenable => clientemactxenable,
			clientemacpausereq => clientemacpausereq,
			clientemacpauseval => clientemacpauseval,
			emacclientrxd => emacclientrxd,
			emacclientrxdvld => emacclientrxdvld,
			emacclientrxgoodframe => emacclientrxgoodframe,
			emacclientrxbadframe => emacclientrxbadframe,
			clientemacrxenable => clientemacrxenable,
			emacclienttxstats => emacclienttxstats,
			emacclienttxstatsvld => emacclienttxstatsvld,
			emacclientrxstats => emacclientrxstats,
			emacclientrxstatsvld => emacclientrxstatsvld,
			tieemacunicastaddr => tieemacunicastaddr,
			txgmiimiiclk => txgmiimiiclk,
			rxgmiimiiclk => rxgmiimiiclk,
			speedis100 => speedis100,
			speedis10100 => speedis10100,
			hostclk => hostclk,
			hostopcode => hostopcode,
			hostreq => hostreq,
			hostmiimsel => hostmiimsel,
			hostaddr => hostaddr,
			hostwrdata => hostwrdata,
			hostmiimrdy => hostmiimrdy,
			hostrddata => hostrddata,
			corehassgmii => corehassgmii);
-- INST_TAG_END ------ End INSTANTIATION Template ------------

