library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_NPC_SRC is
	Port (
		pc 		: in  STD_LOGIC_VECTOR (31 downto 0);
		disp22 	: in  STD_LOGIC_VECTOR (31 downto 0);
		disp30 	: in  STD_LOGIC_VECTOR (31 downto 0);
		alurs 	: in  STD_LOGIC_VECTOR (31 downto 0);
		pc_src 	: in  STD_LOGIC_VECTOR (1 downto 0);
		pc_out 	: out  STD_LOGIC_VECTOR (31 downto 0)
	);
end MUX_NPC_SRC;

architecture Behavioral of MUX_NPC_SRC is

begin

	process(pc,disp22,disp30,alurs,pc_src)
	begin
		case pc_src is
			when "00" =>
				pc_out <= alurs;
			when "01" =>
				pc_out <= disp30;
			when "10" =>
				pc_out <= disp22;
			when "11" =>
				pc_out <= pc;
			when others =>
				pc_out <= pc;
		end case;
	end process;

end Behavioral;