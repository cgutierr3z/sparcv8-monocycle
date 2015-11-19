--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:18:01 10/11/2015
-- Design Name:   
-- Module Name:   C:/Users/Zetta/Desktop/sparcv8/ALU_tb.vhd
-- Project Name:  sparcv8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         ope1 : IN  std_logic_vector(31 downto 0);
         ope2 : IN  std_logic_vector(31 downto 0);
         aluop : IN  std_logic_vector(5 downto 0);
         alurs : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ope1 : std_logic_vector(31 downto 0) := (others => '0');
   signal ope2 : std_logic_vector(31 downto 0) := (others => '0');
   signal aluop : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal alurs : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          ope1 => ope1,
          ope2 => ope2,
          aluop => aluop,
          alurs => alurs
        );

   -- Clock process definitions


   -- Stimulus process
   stim_proc: process
   begin		
      
		ope1 <= x"00000035";
      ope2 <= x"00000003";
      aluop <= "100100";
      wait for 20 ns;	
		
		ope1 <= x"00000035";
      ope2 <= x"00000003";
      aluop <= "100000";
      wait for 20 ns;	
		
		ope1 <= x"00000035";
      ope2 <= x"00000003";
      aluop <= "110000";
      wait for 20 ns;	

      

      wait;
   end process;

END;
