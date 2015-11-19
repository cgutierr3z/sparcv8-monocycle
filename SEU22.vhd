library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SEU22 is
	Port ( 
		disp22 	: in  STD_LOGIC_VECTOR (21 downto 0);
		sign_ext : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end SEU22;

architecture Behavioral of SEU22 is

begin

	process(disp22)
	begin
		if(disp22(21) = '0')then
			sign_ext(31 downto 22) <= (others=>'0');
			sign_ext(21 downto 0) <= disp22;
		else
			sign_ext(31 downto 22) <= (others=>'1');
			sign_ext(21 downto 0) <= disp22;
		end if;
	end process;
	
end Behavioral;