library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
	Port (
		clk	: in  STD_LOGIC;
		reset : in  STD_LOGIC;
		rs1 	: in  STD_LOGIC_VECTOR (5 downto 0);
		rs2 	: in  STD_LOGIC_VECTOR (5 downto 0);
		rd 	: in  STD_LOGIC_VECTOR (5 downto 0);
		we 	: in  STD_LOGIC;
		dwr	: in 	STD_LOGIC_VECTOR (31 downto 0);
		crs1 	: out  STD_LOGIC_VECTOR (31 downto 0);
		crs2 	: out  STD_LOGIC_VECTOR (31 downto 0);
		crd 	: out  STD_LOGIC_VECTOR (31 downto 0)
	);
end RF;

architecture Behavioral of RF is

	type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
	signal regs : ram_type := (others => x"00000000");
	signal tmp 	: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	
begin

	process (reset,rs1,rs2,rd,we,dwr,regs,clk) is
	begin
		
		if (reset = '1') then
			crs1 <= (others=>'0');
			crs2 <= (others=>'0');
			crd <= (others=>'0');
			regs <= (others => x"00000000");
		else
			if falling_edge(clk) then
				if(we = '1' and rd /= "000000") then
					regs(conv_integer(rd)) <= dwr;
				end if;
			end if;
			
			tmp <= regs(conv_integer(rd));
			if rd = rs1 then
				crs1 <= tmp;
				crs2 <= regs(conv_integer(rs2));
				crd <= regs(conv_integer(rd));
			elsif rd = rs2 then
				crs1 <= regs(conv_integer(rs1));
				crs2 <= tmp;
				crd <= regs(conv_integer(rd));
			else
				crs1 <= regs(conv_integer(rs1));
				crs2 <= regs(conv_integer(rs2));
				crd <= regs(conv_integer(rd));
			end if;
			
		end if;
		
		
		
		
--		elsif falling_edge(clk) then
--		
--			if(we = '1' and rd /= "00000") then
--				regs(conv_integer(rd)) <= dwr;
--			end if;
--		
--		else--if(rising_edge(clk)) then
--			tmp <= regs(conv_integer(rd));
--			if rd = rs1 then
--				crs1 <= tmp;
--				crs2 <= regs(conv_integer(rs2));
--			elsif rd = rs2 then
--				crs1 <= regs(conv_integer(rs1));
--				crs2 <= tmp;
--			else
--				crs1 <= regs(conv_integer(rs1));
--				crs2 <= regs(conv_integer(rs2));
--			end if;
--		end if;
		
	end process;
	
end Behavioral;

