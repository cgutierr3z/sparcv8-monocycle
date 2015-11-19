library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_RF_NRD is
	Port ( 
		nrd 	: in  STD_LOGIC_VECTOR (5 downto 0);
		r7 	: in  STD_LOGIC_VECTOR (5 downto 0);
		rf_dtn 	: in  STD_LOGIC;
		out_nrd 	: out  STD_LOGIC_VECTOR (5 downto 0)
	);
end MUX_RF_NRD;

architecture Behavioral of MUX_RF_NRD is

begin

	process(nrd,r7,rf_dtn)
	begin
	
		if(rf_dtn = '0')then
			out_nrd <= nrd;
		elsif(rf_dtn = '1')then
			out_nrd <= r7;
		end if;
		
	end process;
	
end Behavioral;

