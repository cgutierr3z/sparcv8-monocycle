library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSR_MOD is
	Port ( 
		alurs : in  STD_LOGIC_VECTOR (31 downto 0);
		ope1 	: in  STD_LOGIC;
		ope2 	: in  STD_LOGIC;
		aluop : in  STD_LOGIC_VECTOR (5 downto 0);
		nzvc 	: out std_logic_vector(3 downto 0)
	);
end PSR_MOD;

architecture Behavioral of PSR_MOD is

begin

	process(alurs,ope1,ope2,aluop)
	begin
		--ADDcc ADDXcc
		if (aluop = "100001" or aluop = "100011") then
			nzvc(3) <= alurs(31);	
			if(alurs = X"00000000")then
				nzvc(2) <= '1';
			else
				nzvc(2) <= '0';
			end if;
			nzvc(1) <= (ope1 and ope2 and (not alurs(31))) or ((ope1) and (not ope2) and alurs(31));
			nzvc(0) <= (ope1 and ope2) or ((not alurs(31)) and (ope1 or ope2));
			
		--SUBcc SUBXcc 
		elsif (aluop = "100101" or aluop = "100111") then 
				nzvc(3) <= alurs(31);
				if(alurs = X"00000000")then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= ((ope1 and (not ope2) and (not alurs(31))) or ((not ope1) and ope2 and alurs(31)));
				nzvc(0) <= ((not ope1) and ope2) or (alurs(31) and ((not ope1) or ope2));
		
		--ANDcc ANDNcc ORcc ORNcc XORcc XNORcc
		elsif(aluop = "101001" or aluop = "101011" or aluop = "101101" or aluop = "101111" or aluop = "110001" or aluop = "110011")then
				nzvc(3) <= alurs(31);
				if(alurs = X"00000000") then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= '0';
				nzvc(0) <= '0';
				
--		--RESTO DE OPERACIONES
--		else
--				nzvc <= "0000";
		end if;

		
	end process;
end Behavioral;

