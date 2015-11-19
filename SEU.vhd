library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SEU is
	Port (
		imm13 	: in  STD_LOGIC_VECTOR (12 downto 0);
		sign_ext : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end SEU;

architecture Behavioral of SEU is

begin

	process(imm13)
	begin
			if(imm13(12) = '0') then
				sign_ext(31 downto 13) <= (others=>'0');
				sign_ext(12 downto 0) <= imm13;
			else
				sign_ext(31 downto 13) <= (others=>'1');
				sign_ext(12 downto 0) <= imm13;
			end if;
	end process;

end Behavioral;

