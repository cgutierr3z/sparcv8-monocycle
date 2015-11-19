library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_RF_DWR is
	Port ( 
		data_dm 	: in  STD_LOGIC_VECTOR (31 downto 0);
		alurs 	: in  STD_LOGIC_VECTOR (31 downto 0);
		pc 		: in  STD_LOGIC_VECTOR (31 downto 0);
		rf_src 	: in  STD_LOGIC_VECTOR (1 downto 0);
		rf_data 	: out  STD_LOGIC_VECTOR (31 downto 0)
	);
end MUX_RF_DWR;

architecture Behavioral of MUX_RF_DWR is

begin
	process(data_dm,alurs,pc,rf_src)
	begin
		case rf_src is
			when "00" =>
				rf_data <= data_dm;
			when "01" =>
				rf_data <= alurs;
			when "10" =>
				rf_data <= pc;
			when others =>
				rf_data <= (others =>'0');
		end case;
	end process;

end Behavioral;