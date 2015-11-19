library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IM is
	Port ( 
		--clk 		: in  STD_LOGIC;
		reset 	: in  STD_LOGIC;
		address 	: in  STD_LOGIC_VECTOR (31 downto 0);
		inst_out	: out  STD_LOGIC_VECTOR (31 downto 0)
	);
end IM;

architecture Behavioral of IM is

	type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);
		
	impure function load_ils (file_name : in string) return rom_type is
		FILE instruction : text open read_mode is file_name;
		variable instructionsLine : line;
		variable temp_bv : bit_vector(31 downto 0);
		variable temp_mem : rom_type;
		
		begin
			for i in rom_type'range loop
				readline (instruction, instructionsLine);
				read(instructionsLine, temp_bv);
				temp_mem(i) := to_stdlogicvector(temp_bv);
			end loop;
		return temp_mem;
		
	end function;
	
	signal instructions : rom_type := load_ils("programMul.data");

begin

	process(reset,address,instructions)--,clk)
	begin
			if(reset = '1')then
				inst_out <= (others=>'0');
			else--if(rising_edge(clk)) then
				inst_out <= instructions(conv_integer(address(5 downto 0)));
			end if;
	end process;

end Behavioral;

