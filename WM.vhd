----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:10:56 10/28/2012 
-- Design Name: 
-- Module Name:    WM - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WM is
	Port ( 
		op 	: in  STD_LOGIC_VECTOR (1 downto 0);
		op3 	: in  STD_LOGIC_VECTOR (5 downto 0);
		cwp 	: in  STD_LOGIC_VECTOR (1 downto 0);
		rs1 	: in  STD_LOGIC_VECTOR (4 downto 0);
		rs2 	: in  STD_LOGIC_VECTOR (4 downto 0);
		rd 	: in  STD_LOGIC_VECTOR (4 downto 0);
		ncwp 	: out  STD_LOGIC_VECTOR (1 downto 0);
		nrs1 	: out  STD_LOGIC_VECTOR (5 downto 0);
		nrs2 	: out  STD_LOGIC_VECTOR (5 downto 0);
		nrd 	: out  STD_LOGIC_VECTOR (5 downto 0);
		r7 	: out STD_LOGIC_VECTOR(5 downto 0)
	);
end WM;

architecture Behavioral of WM is

	signal rs1Integer, rs2Integer, rdInteger: integer range 0 to 39;
	signal auxR7 : std_logic_vector(6 downto 0);
	
	signal cwpi : std_logic_vector(1 downto 0);
	
begin	
	auxR7 <= cwp * "10000";--OJO en lugar de "00" debe ir cwp
	r7 <= auxR7(5 downto 0) + "001111";

	process(rs1,rs2,rd,cwp,cwpi,op,op3)--,clk)
	begin
	--if(rising_edge(clk)) then

		--SAVE --RESTORE
		if( (op3 = "111100" or op3 = "111101") and op = "10") then
			if(cwp = "00") then
				cwpi <= "01";
				ncwp <= "01";
			elsif(cwp = "01") then
				cwpi <= "00";
				ncwp <= "00";
			end if;
		else
				cwpi <= cwp;
				ncwp <= cwp;
		end if;
		
			
		if(rd>="00000" and rd<="00111") then
			--globals
			rdInteger <= conv_integer(rd);
		elsif(rd>="01000" and rd<="01111") then
			--outputs
			rdInteger <= conv_integer(rd) + (conv_integer(cwpi)*16);
		elsif(rd>="10000" and rd<="10111") then
			--locals
			rdInteger <= conv_integer(rd) + (conv_integer(cwpi)*16);
		elsif(rd>="11000" and rd<="11111") then
			--inputs
			rdInteger <= conv_integer(rd) - (conv_integer(cwpi)*16);
		end if;
		
		
		if(rs1>="00000" and rs1<="00111") then
			--globals
			rs1Integer <= conv_integer(rs1);
		elsif(rs1>="01000" and rs1<="01111") then
			--outputs
			rs1Integer <= conv_integer(rs1) + (conv_integer(cwp)*16);
		elsif(rs1>="10000" and rs1<="10111") then
			--locals
			rs1Integer <= conv_integer(rs1) + (conv_integer(cwp)*16);
		elsif(rs1>="11000" and rs1<="11111") then
			--inputs
			rs1Integer <= conv_integer(rs1) - (conv_integer(cwp)*16);
		end if;
		
		if(rs2>="00000" and rs2<="00111") then
			--globals
			rs2Integer <= conv_integer(rs2);
		elsif(rs2>="01000" and rs2<="01111") then
			--outputs
			rs2Integer <= conv_integer(rs2) + (conv_integer(cwp)*16);
		elsif(rs2>="10000" and rs2<="10111") then
			--locals
			rs2Integer <= conv_integer(rs2) + (conv_integer(cwp)*16);
		elsif(rs2>="11000" and rs2<="11111") then
			--inputs
			rs2Integer <= conv_integer(rs2) - (conv_integer(cwp)*16);
		end if;


	--end if;
	end process;
	
	nrs1 	<= conv_std_logic_vector(rs1Integer, 6);
	nrs2 	<= conv_std_logic_vector(rs2Integer, 6);
	nrd	<= conv_std_logic_vector(rdInteger, 6);
	
end Behavioral;

