library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sparcv8_v4 is
	Port ( 
		clk 	: in  STD_LOGIC;
		reset : in  STD_LOGIC;
		alurs : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end sparcv8_v4;

architecture Behavioral of sparcv8_v4 is

	component ADD
		Port ( 
			add		: in  STD_LOGIC_VECTOR (31 downto 0);
			input		: in  STD_LOGIC_VECTOR (31 downto 0);
			output	: out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;

	component ALU
		Port ( 
			ope1 	: in  STD_LOGIC_VECTOR (31 downto 0);
			ope2 	: in  STD_LOGIC_VECTOR (31 downto 0);
			aluop : in  STD_LOGIC_VECTOR (5 downto 0);
			C     : in  STD_LOGIC;
			alurs : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component CU
		Port (
			--clk 	: in  STD_LOGIC;
			op 	: in  STD_LOGIC_VECTOR (1 downto 0);
			op3 	: in  STD_LOGIC_VECTOR (5 downto 0);
			aluop : out  STD_LOGIC_VECTOR (5 downto 0)
		);
	end component;
	
	component IM
		Port ( 
			--clk 		: in  STD_LOGIC;
			reset 	: in  STD_LOGIC;
			address 	: in  STD_LOGIC_VECTOR (31 downto 0);
			inst_out	: out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;

	component MUX 
		Port ( 
			crs2 	: in  STD_LOGIC_VECTOR (31 downto 0);
			immSE : in  STD_LOGIC_VECTOR (31 downto 0);
			i 		: in  STD_LOGIC;
			ope2 	: out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;

	component PC 
		Port ( 
			CLK 		: in  STD_LOGIC;
			RESET 	: in  STD_LOGIC;
			PC_IN 	: in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			PC_OUT 	: out  STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	end component;

	component RF
		Port (
			clk	: in  STD_LOGIC;
			reset : in  STD_LOGIC;
			rs1 	: in  STD_LOGIC_VECTOR (5 downto 0);
			rs2 	: in  STD_LOGIC_VECTOR (5 downto 0);
			rd 	: in  STD_LOGIC_VECTOR (5 downto 0);
			we 	: in  STD_LOGIC;
			dwr	: in 	STD_LOGIC_VECTOR (31 downto 0);
			crs1 	: out  STD_LOGIC_VECTOR (31 downto 0);
			crs2 	: out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;

	component SEU
		Port (
			imm13 	: in  STD_LOGIC_VECTOR (12 downto 0);
			sign_ext : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component WM
		Port ( 
			op 	: in  STD_LOGIC_VECTOR (1 downto 0);
			op3 	: in  STD_LOGIC_VECTOR (5 downto 0);
			cwp 	: in  STD_LOGIC_VECTOR (1 downto 0);
			rs1 	: in  STD_LOGIC_VECTOR (4 downto 0);
			rs2 	: in  STD_LOGIC_VECTOR (4 downto 0);
			rd 	: in  STD_LOGIC_VECTOR (4 downto 0);
			ncwp 	: out  STD_LOGIC_VECTOR (1 downto 0);
			nrs1 	: out  STD_LOGIC_VECTOR (5 downto 0);
			nrs2 	: out  STD_LOGIC_VECTOR (5 downto 0);
			nrd 	: out  STD_LOGIC_VECTOR (5 downto 0)
		);
	end component;
	
	component PSR
		Port ( 
			clk 	: in  STD_LOGIC;
			reset : in  STD_LOGIC;
			nzvc 	: in  STD_LOGIC_VECTOR (3 downto 0);
			ncwp 	: in  STD_LOGIC_VECTOR (1 downto 0);
			cwp 	: out  STD_LOGIC_VECTOR (1 downto 0);
			carry	: out  STD_LOGIC
		);
	end component;
	
	component PSR_MOD
		Port ( 
			alurs : in  STD_LOGIC_VECTOR (31 downto 0);
			ope1 : in  STD_LOGIC;
			ope2 : in  STD_LOGIC;
			aluop : in  STD_LOGIC_VECTOR (5 downto 0);
			nzvc : out std_logic_vector(3 downto 0)
		);
	end component;
			
	--internal out signals ADD, nPC and PC
	signal addi : std_logic_vector(31 downto 0);
	signal npci : std_logic_vector(31 downto 0);
	signal pci	: std_logic_vector(31 downto 0);

	--internal out signal CU
	signal aluop : std_logic_vector(5 downto 0);
	
	--internal out signals RF
	signal crs1 : std_logic_vector(31 downto 0);
	signal crs2 : std_logic_vector(31 downto 0);
	
	--internal out signal SEU
	signal imm31 : std_logic_vector(31 downto 0);
	
	--internal out signal MUX
	signal ope2 : std_logic_vector(31 downto 0);
	
	--internal out signal ALU
	signal alursi : std_logic_vector(31 downto 0);
	
	--internal out signal PSR_MOD
	signal nzvc 	: std_logic_vector(3 downto 0);
	
	--internal out signals PSR
	signal cwp 		: STD_LOGIC_VECTOR (1 downto 0);
	signal carry 	: STD_LOGIC;
	
	--internal out signal IM
	signal im_o : std_logic_vector(31 downto 0);
	--instruction format
	signal op 	: STD_LOGIC_VECTOR (1 downto 0);
	signal op3 	: STD_LOGIC_VECTOR (5 downto 0);
	signal rd 	: STD_LOGIC_VECTOR (4 downto 0);
	signal rs1 	: STD_LOGIC_VECTOR (4 downto 0);
	signal i 	: STD_LOGIC;
	signal imm13: STD_LOGIC_VECTOR (12 downto 0);
	signal rs2 	: STD_LOGIC_VECTOR (4 downto 0);
	
	--internal out signals WM
	signal ncwp 	: STD_LOGIC_VECTOR (1 downto 0);
	signal nrs1 	: STD_LOGIC_VECTOR (5 downto 0);
	signal nrs2 	: STD_LOGIC_VECTOR (5 downto 0);
	signal nrd	 	: STD_LOGIC_VECTOR (5 downto 0);
	
	

begin
	add_map : ADD port map(
		x"00000001", npci, addi
	);

	npc_map : PC port map(
		clk, reset, addi, npci
	);
	
	pc_map : PC port map(
		clk, reset, npci, pci
	);
	
	im_map : IM port map(
		reset, pci, im_o
	);
	
	op 	<= im_o(31 downto 30);
	op3 	<= im_o(24 downto 19);
	rd 	<= im_o(29 downto 25);
	rs1 	<= im_o(18 downto 14);
	i 		<= im_o(13);
	imm13 <= im_o(12 downto 0);
	rs2 	<= im_o(4 downto 0);
	
	cu_map : CU port map(
		op, op3, aluop
	);
	
	rf_map : RF port map(
		clk, reset, nrs1, nrs2, nrd, '1', alursi, crs1, crs2
	);
	
	seu_map : SEU port map(
		imm13, imm31
	);
	
	mux_map : MUX port map(
		crs2, imm31, i, ope2
	);
	
	wm_map : WM port map(
		op, op3, cwp, rs1, rs2, rd, ncwp, nrs1, nrs2, nrd
	);
	
	psr_map : PSR port map(
		clk, reset, nzvc, ncwp, cwp, carry
	);
	
	psrmod_map : PSR_MOD port map(
		alursi, crs1(31), ope2(31), aluop, nzvc
	);
	
	alu_map : ALU port map(
		crs1, ope2, aluop, carry, alursi
	);
	
	alurs <= alursi;

end Behavioral;


