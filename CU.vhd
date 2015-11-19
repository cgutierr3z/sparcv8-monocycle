library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CU is
	Port (
		--clk	: in STD_LOGIC;
		op 	: in  STD_LOGIC_VECTOR (1 downto 0);
		op2 	: in  STD_LOGIC_VECTOR (2 downto 0);
		op3 	: in  STD_LOGIC_VECTOR (5 downto 0);
		cond 	: in  STD_LOGIC_VECTOR (3 downto 0);
		icc 	: in  STD_LOGIC_VECTOR (3 downto 0);
		aluop : out  STD_LOGIC_VECTOR (5 downto 0);
		en_dm : out  STD_LOGIC;
		we_dm : out  STD_LOGIC;
		pc_src: out  STD_LOGIC_VECTOR (1 downto 0);
		we_rf : out  STD_LOGIC;
		rf_src: out  STD_LOGIC_VECTOR (1 downto 0);
		rf_dtn: out  STD_LOGIC
	);
end CU;

architecture Behavioral of CU is

begin

	process(op,op2,op3,cond,icc)--, clk)
	begin
		--if (rising_edge(clk)) then
			-- OP = 10
			case op is
				when "00" =>
					case op2 is
						when "010" =>
							case cond is
								--BA 1
								when "1000" => 
									--1
									aluop <= "000001";
									en_dm <= '1';
									we_dm <= '0';
									pc_src <= "10"; 	--pc+disp22
									we_rf <= '0';			
									rf_src <= "00"; 
									rf_dtn <= '0'; 
									
								--BN 2
								when "0000" => 
									--0
									aluop <= "000010";
									en_dm <= '1';
									we_dm <= '0';
									pc_src <= "11"; 	--pc
									we_rf <= '0';			
									rf_src <= "00"; 
									rf_dtn <= '0'; 
								
								-- BNE 3
								when "1001" => 
									aluop <= "000011";
									en_dm <= '1';
									we_dm <= '0';
									--not Z
									if(not(icc(2)) = '1') then
										pc_src <= "10"; 	--pc+disp22
									else
										pc_src <= "11"; 	--pc
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
									
								--BE 4
								when "0001" =>
									aluop <= "000100";
									en_dm <= '1';
									we_dm <= '0';
									--Z
									if(icc(2) = '1') then
										pc_src <= "10"; 	--pc+disp22
									else
										pc_src <= "11"; 	--pc
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
									
								--BG 5
								when "1010" => 
									aluop <= "000101";
									en_dm <= '1';
									we_dm <= '0';
									-- not(Z or (N xor V))
									if((not(icc(2) or (icc(3) xor icc(1)))) = '1') then 										
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
								
								--BLE 6
								when "0010" => 
									aluop <= "000110";
									en_dm <= '1';
									we_dm <= '0';
									--Z or (N xor V)
									if((icc(2) or (icc(3) xor icc(1))) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
									
								-- BGE 7
								when "1011" => 
									aluop <= "000111";
									en_dm <= '1';
									we_dm <= '0';
									--not (N xor V)
									if((not(icc(3) xor icc(1))) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
									
								--BL 8
								when "0011" =>
									aluop <= "001000";
									en_dm <= '1';
									we_dm <= '0';
									-- (N xor V)
									if((icc(3) xor icc(1)) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
									
								--BGU 9
								when "1100" =>
									aluop <= "001001";
									en_dm <= '1';
									we_dm <= '0';
									-- not(C or Z)
									if((not(icc(0) or icc(2))) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
								
								--BLEU 10
								when "0100" =>
									aluop <= "001010";
									en_dm <= '1';
									we_dm <= '0';
									-- (C or Z)
									if((icc(0) or icc(2)) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
									
								--BCC 11
								when "1101" =>
									aluop <= "001011";
									en_dm <= '1';
									we_dm <= '0';
									--not C
									if(not(icc(0)) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
									
								--BCS 12
								when "0101" =>
									aluop <= "001100";
									en_dm <= '1';
									we_dm <= '0';
									--C
									if(icc(0) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
								
								--BPOS 13
								when "1110" =>
									aluop <= "001101";
									en_dm <= '1';
									we_dm <= '0';
									--not N
									if(not(icc(3)) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
									
								--BNEG 14
								when "0110" =>
									aluop <= "001110";
									en_dm <= '1';
									we_dm <= '0';
									--N
									if(icc(3) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
									
								--BVC 15
								when "1111" =>
									aluop <= "001111";
									en_dm <= '1';
									we_dm <= '0';
									--not V
									if(not(icc(1)) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';
								
								--BVS 16
								when "0111" =>
									aluop <= "010000";
									en_dm <= '1';
									we_dm <= '0';
									--V
									if(icc(1) = '1') then 
										pc_src <= "10"; 	--pc+disp22										
									else										
										pc_src <= "11"; 	--pc										 
									end if;
									we_rf <= '0';
									rf_src <= "00";
									rf_dtn <= '0';								
								
								when others =>																			
									aluop <= (others=>'1');
									en_dm <= '0';
									we_dm <= '0'; --
									pc_src <= "11"; 	--pc --
									we_rf <= '0'; 		
									rf_src <= "01"; 	--alurs
									rf_dtn <= '0'; 	--nrd
							end case;
						
						when "100" =>
							-- NOP 19
							aluop <= "010011";
							en_dm <= '1';
							we_dm <= '0'; 
							pc_src <= "11"; 	--pc
							we_rf <= '0'; 		 
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
							
						when others =>
							aluop <= (others=>'1');
							en_dm <= '0';
							we_dm <= '0'; 
							pc_src <= "11"; 	--pc
							we_rf <= '0'; 		
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
							
					end case;
				
				-- op = 01
				when "01" =>
					--CALL 0
					aluop <= "000000"; 
					en_dm <= '1';
					we_dm <= '0';
					pc_src <= "01"; 	--pc+disp30
					we_rf <= '1';
					rf_src <= "10"; 	--pc
					rf_dtn <= '1'; 	
				
				-- op = 10
				when "10" =>
					case op3 is
						--ADD 32
						when "000000" => 
							aluop <= "100000";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";	--pc  
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--ADDcc
						when "010000" => 
							aluop <= "100001";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--ADDX
						when "001000" => 
							aluop <= "100010";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--ADDXcc
						when "011000" => 
							aluop <= "100011";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						
						--SUB 36
						when "000100" => 
							aluop <= "100100";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--SUBcc
						when "010100" => 
							aluop <= "100101";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--SUBX
						when "001100" => 
							aluop <= "100110";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--SUBXcc
						when "011100" => 
							aluop <= "100111";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd

						--AND 40
						when "000001" => 
							aluop <= "101000";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--ANDcc
						when "010001" => 
							aluop <= "101001";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--ANDN
						when "000101" => 
							aluop <= "101010";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--ANDNcc
						when "010101" => 
							aluop <= "101011";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--OR
						when "000010" => 
							aluop <= "101100";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--ORcc
						when "010010" => 
							aluop <= "101101";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--ORN
						when "000110" => 
							aluop <= "101110";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--ORNcc
						when "010110" => 
							aluop <= "101111";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--XOR
						when "000011" => 
							aluop <= "110000";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--XORcc
						when "010011" => 
							aluop <= "110001";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--XNOR
						when "000111" => 
							aluop <= "110010";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--XNORcc 51
						when "010111" => 
							aluop <= "110011";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						
						--SAVE 57
						when "111100" => 
							aluop <= "111001";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
						--RESTORE 58
						when "111101" => 
							aluop <= "111010";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
							
						--JMPL 59
						when "111000" => 
							aluop <= "111011";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "00";  	--alurs
							we_rf <= '1';
							rf_src <= "10"; 	--pc
							rf_dtn <= '0'; 	--nrd	
						
						
						when others => 
							aluop <= (others=>'1');
							en_dm <= '0';
							we_dm <= '0'; 
							pc_src <= "11"; 	--pc
							we_rf <= '0'; 		
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 
							
					end case;
				
				-- OP = 11
				when "11" =>
					case op3 is
						--LD 55
						when "000000" =>
							aluop <= "110111";
							en_dm <= '1';
							we_dm <= '0';
							pc_src <= "11";  	--pc
							we_rf <= '1';
							rf_src <= "00"; 	--dm
							rf_dtn <= '0'; 	--nrd
							
						--ST 56
						when "000100" =>
							aluop <= "111000";
							en_dm <= '1';
							we_dm <= '1';
							pc_src <= "11";  	--pc
							we_rf <= '0';
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 	--nrd
							
						when others => 
							aluop <= (others=>'1');
							en_dm <= '0';
							we_dm <= '0'; 
							pc_src <= "11"; 	--pc
							we_rf <= '0'; 		
							rf_src <= "01"; 	--alurs
							rf_dtn <= '0'; 
					end case;
					
				when others => 
					aluop <= (others=>'1');
					en_dm <= '0';
					we_dm <= '0'; 
					pc_src <= "11"; 	--pc
					we_rf <= '0'; 		
					rf_src <= "01"; 	--alurs
					rf_dtn <= '0'; 
						
			end case;
		--end if; -- risingEdge
	end process;

end Behavioral;

