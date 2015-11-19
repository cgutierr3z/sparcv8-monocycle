library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX is
	Port ( 
		crs2 	: in  STD_LOGIC_VECTOR (31 downto 0);
		immSE : in  STD_LOGIC_VECTOR (31 downto 0);
		i 		: in  STD_LOGIC;
		ope2 	: out  STD_LOGIC_VECTOR (31 downto 0)
	);
end MUX;

architecture Behavioral of MUX is

begin

    process (crs2, immSE, i)
    begin
      case i is 
         when '0' => ope2 <= crs2;	
         when '1' => ope2 <= immSE;
			when others => ope2 <= (others =>'0');
      end case;
    end process;

end Behavioral;

