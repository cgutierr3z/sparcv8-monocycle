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

entity DM is
	Port ( 
		clk 	: in  STD_LOGIC;
		reset : in  STD_LOGIC;
		addr	: in  STD_LOGIC_VECTOR (31 downto 0);
		en 	: in  STD_LOGIC;
		we 	: in  STD_LOGIC;
		crd 	: in  STD_LOGIC_VECTOR (31 downto 0);				
		data 	: out  STD_LOGIC_VECTOR (31 downto 0)
	);
end DM;

architecture Behavioral of DM is

	type ram_type is array (0 to 63) of std_logic_vector (31 downto 0);
	signal ram : ram_type := (others => x"00000000");
	
begin

	process(clk,addr,we,en,crd)
	begin
		if(rising_edge(clk)) then
			if(en = '1') then
				if(reset = '1') then
					data <= (others => '0');
					ram <= (others => x"00000000");
					
				elsif(we = '0') then
					data <= ram(conv_integer(addr(5 downto 0)));
					
				else
					ram(conv_integer(addr(5 downto 0))) <= crd;
					
				end if;
			end if;
		end if;
		
	end process;
	
end Behavioral;