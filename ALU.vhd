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

entity ALU is
	Port ( 
		ope1 	: in  STD_LOGIC_VECTOR (31 downto 0);
		ope2 	: in  STD_LOGIC_VECTOR (31 downto 0);
		aluop : in  STD_LOGIC_VECTOR (5 downto 0);
		carry : in  STD_LOGIC;
		alurs : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end ALU;

architecture Behavioral of ALU is

begin

	process(ope1,ope2,aluop, carry)
	begin
	   case aluop is 
			-- ADD
			when "100000" => alurs <= ope1 + ope2;
			-- ADDcc
			when "100001" => alurs <= ope1 + ope2;
			-- ADDX
			when "100010" => alurs <= ope1 + ope2 + carry;
			--ADDXcc
			when "100011" => alurs <= ope1 + ope2 + carry;
			
			-- SUB
			when "100100" => alurs <= ope1 - ope2;
			-- SUBcc
			when "100101" => alurs <= ope1 - ope2;
			-- SUBX
			when "100110" => alurs <= ope1 - ope2 - carry;
			--SUBXcc
			when "100111" => alurs <= ope1 - ope2 - carry;
			
			-- AND
			when "101000" => alurs <= ope1 and ope2;
			-- ANDcc
			when "101001" => alurs <= ope1 and ope2;
			-- ANDN
			when "101010" => alurs <= ope1 nand ope2;
			-- ANDNcc
			when "101011" => alurs <= ope1 nand ope2;
			
			-- OR
			when "101100" => alurs <= ope1 or ope2;
			-- ORcc
			when "101101" => alurs <= ope1 or ope2;
			-- ORN
			when "101110" => alurs <= ope1 nor ope2;
			-- ORNcc
			when "101111" => alurs <= ope1 nor ope2;
			
			-- XOR
			when "110000" => alurs <= ope1 xor ope2;
			-- XORcc
			when "110001" => alurs <= ope1 xor ope2;
			-- XNOR
			when "110010" => alurs <= ope1 xnor ope2;
			-- XNORcc
			when "110011" => alurs <= ope1 xnor ope2;
			
			--SAVE 57
			when "111001" => alurs <= ope1 + ope2;
			--RESTORE 58
			when "111010" => alurs <= ope1 + ope2;
				
			when others => alurs <= (others=>'0');
		end case;
	end process;
	
end Behavioral;

