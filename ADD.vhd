library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADD is
	Port ( 
		add		: in  STD_LOGIC_VECTOR (31 downto 0);
		input		: in  STD_LOGIC_VECTOR (31 downto 0);
		output	: out  STD_LOGIC_VECTOR (31 downto 0)
	);
end ADD;

architecture Behavioral of ADD is

begin

	process(add,input)
	begin
	
		output <= input + add;
		
	end process;

end Behavioral;

