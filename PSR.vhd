library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PSR is
	Port ( 
		clk 	: in  STD_LOGIC;
		reset : in  STD_LOGIC;
		nzvc 	: in  STD_LOGIC_VECTOR (3 downto 0);
		ncwp 	: in  STD_LOGIC_VECTOR (1 downto 0);
		cwp 	: out  STD_LOGIC_VECTOR (1 downto 0);
		carry	: out  STD_LOGIC
	);
end PSR;

architecture Behavioral of PSR is

signal psr_reg: STD_LOGIC_VECTOR (31 DOWNTO 0):= (others=>'0');

begin
	process(clk, reset, nzvc, ncwp)
	begin
	
		if(reset = '1') then
			cwp <= "00";
			carry <= '0';
		elsif(rising_edge(clk)) then
			psr_reg(23 downto 20) <= nzvc;
			psr_reg(1 downto 0) <= ncwp;
			cwp <= ncwp;--psr_reg(1 downto 0);
			carry <= nzvc(0);--psr_reg(20);
		end if;
		
	end process;	
end Behavioral;

