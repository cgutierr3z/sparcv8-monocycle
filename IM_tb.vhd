--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:09:33 10/11/2015
-- Design Name:   
-- Module Name:   C:/Users/Zetta/Desktop/sparcv8/IM_tb.vhd
-- Project Name:  sparcv8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IM
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY IM_tb IS
END IM_tb;
 
ARCHITECTURE behavior OF IM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IM
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         address : IN  std_logic_vector(31 downto 0);
         inst_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal address : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal inst_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IM PORT MAP (
          clk => clk,
          reset => reset,
          address => address,
          inst_out => inst_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		address <= x"00000000";
      wait for clk_period;
		
		address <= x"00000001";
      wait for clk_period;
		
		address <= x"00000002";
      wait for clk_period;
		
		address <= x"00000003";
      wait for clk_period;
		
		address <= x"00000005";
      wait for clk_period;
		
		address <= x"00000004";
      wait for clk_period;
		
		address <= x"00000003";
      wait for clk_period;


      wait;
   end process;

END;
