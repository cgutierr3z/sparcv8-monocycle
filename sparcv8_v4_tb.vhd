--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:29:29 10/22/2015
-- Design Name:   
-- Module Name:   C:/Users/Zetta/Desktop/sparcv8/sparcv8_v4_tb.vhd
-- Project Name:  sparcv8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sparcv8_v4
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
 
ENTITY sparcv8_v4_tb IS
END sparcv8_v4_tb;
 
ARCHITECTURE behavior OF sparcv8_v4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sparcv8_v4
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         alurs : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal alurs : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sparcv8_v4 PORT MAP (
          clk => clk,
          reset => reset,
          alurs => alurs
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
      reset <= '1';
      wait for clk_period;
		
		reset <= '0';
		
		wait;
   end process;

END;
