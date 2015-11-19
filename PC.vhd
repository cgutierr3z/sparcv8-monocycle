library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
	Port ( 
		CLK 		: in  STD_LOGIC;
		RESET 	: in  STD_LOGIC;
		PC_IN 	: in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_OUT 	: out  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end PC;

architecture Behavioral of PC is

begin

	process(CLK,RESET,PC_IN)
	begin
	
		if (RESET = '1') then
			PC_OUT <= (others => '0');
		elsif (rising_edge(CLK)) then
			PC_OUT <= PC_IN;
		end if;

	end process;

end Behavioral;

