library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sparcv8_v6_monociclo is
	Port ( 
		clk 	: in  STD_LOGIC;
		reset : in  STD_LOGIC;
		alurs : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end sparcv8_v6_monociclo;

architecture Behavioral of sparcv8_v6_monociclo is

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
			carry : in  STD_LOGIC;
			alurs : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component CU
		Port (
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
	end component;
	
	
	component DM
		Port ( 
			clk 	: in  STD_LOGIC;
			reset : in  STD_LOGIC;
			addr	: in  STD_LOGIC_VECTOR (31 downto 0);
			en 	: in  STD_LOGIC;
			we 	: in  STD_LOGIC;
			crd 	: in  STD_LOGIC_VECTOR (31 downto 0);				
			data 	: out  STD_LOGIC_VECTOR (31 downto 0)
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
	
	component MUX_NPC_SRC
		Port (
			pc 		: in  STD_LOGIC_VECTOR (31 downto 0);
			disp22 	: in  STD_LOGIC_VECTOR (31 downto 0);
			disp30 	: in  STD_LOGIC_VECTOR (31 downto 0);
			alurs 	: in  STD_LOGIC_VECTOR (31 downto 0);
			pc_src 	: in  STD_LOGIC_VECTOR (1 downto 0);
			pc_out 	: out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component MUX_RF_DWR
		Port ( 
			data_dm 	: in  STD_LOGIC_VECTOR (31 downto 0);
			alurs 	: in  STD_LOGIC_VECTOR (31 downto 0);
			pc 		: in  STD_LOGIC_VECTOR (31 downto 0);
			rf_src 	: in  STD_LOGIC_VECTOR (1 downto 0);
			rf_data 	: out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component MUX_RF_NRD
		Port ( 
			nrd 	: in  STD_LOGIC_VECTOR (5 downto 0);
			r7 	: in  STD_LOGIC_VECTOR (5 downto 0);
			rf_dtn 	: in  STD_LOGIC;
			out_nrd 	: out  STD_LOGIC_VECTOR (5 downto 0)
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
			crs2 	: out  STD_LOGIC_VECTOR (31 downto 0);
			crd 	: out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;

	component SEU
		Port (
			imm13 	: in  STD_LOGIC_VECTOR (12 downto 0);
			sign_ext : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component SEU22
		Port ( 
			disp22 	: in  STD_LOGIC_VECTOR (21 downto 0);
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
			nrd 	: out  STD_LOGIC_VECTOR (5 downto 0);
			r7 	: out STD_LOGIC_VECTOR(5 downto 0)
		);
	end component;
	
			
	--internal out signals ADD, nPC and PC
	signal addi : std_logic_vector(31 downto 0);
	signal npci : std_logic_vector(31 downto 0);
	signal pci	: std_logic_vector(31 downto 0);

	--internal out signal ALU
	signal alursi : std_logic_vector(31 downto 0);
	
	--internal out signal CU
	signal aluop : std_logic_vector(5 downto 0);
	signal en_dm : STD_LOGIC;
	signal we_dm : STD_LOGIC;
	signal pc_src: STD_LOGIC_VECTOR (1 downto 0);
	signal we_rf : STD_LOGIC;
	signal rf_src: STD_LOGIC_VECTOR (1 downto 0);
	signal rf_dtn: STD_LOGIC;
	
	--internal out signal DM
	signal data :  STD_LOGIC_VECTOR (31 downto 0);
	
	
	--internal out signal IM
	signal im_o : std_logic_vector(31 downto 0);
	--instruction format
	signal op 	: STD_LOGIC_VECTOR (1 downto 0);
	signal op2 	: STD_LOGIC_VECTOR (2 downto 0);
	signal op3 	: STD_LOGIC_VECTOR (5 downto 0);
	signal cond : STD_LOGIC_VECTOR (3 downto 0);
	--signal icc 	: STD_LOGIC_VECTOR (3 downto 0);
	signal rd 	: STD_LOGIC_VECTOR (4 downto 0);
	signal rs1 	: STD_LOGIC_VECTOR (4 downto 0);
	signal i 	: STD_LOGIC;
	signal imm13: STD_LOGIC_VECTOR (12 downto 0);
	signal rs2 	: STD_LOGIC_VECTOR (4 downto 0);
	signal disp22: STD_LOGIC_VECTOR (21 downto 0);
	signal disp30: STD_LOGIC_VECTOR (31 downto 0);
	
	
	--internal out signals PSR
	signal cwp 		: STD_LOGIC_VECTOR (1 downto 0);
	signal carry 	: STD_LOGIC;
	
	--internal out signal PSR_MOD
	signal nzvc 	: std_logic_vector(3 downto 0);
	
	--internal out signals RF
	signal crs1 : std_logic_vector(31 downto 0);
	signal crs2 : std_logic_vector(31 downto 0);
	signal crd	: std_logic_vector(31 downto 0);
	
	--internal out signal SEU and SEU22
	signal imm31 : std_logic_vector(31 downto 0);
	signal seu_disp22 : std_logic_vector(31 downto 0);
	signal seu_disp30 : std_logic_vector(31 downto 0);
	
	signal pc_disp22 : std_logic_vector(31 downto 0);
	signal pc_disp30 : std_logic_vector(31 downto 0);
	
	--internal out signal MUX
	signal ope2 	:  STD_LOGIC_VECTOR (31 downto 0);
	signal pc_out 	:  STD_LOGIC_VECTOR (31 downto 0);
	signal rf_data :  STD_LOGIC_VECTOR (31 downto 0);
	signal out_nrd :  STD_LOGIC_VECTOR (5 downto 0);
	
	--internal out signals WM
	signal ncwp 	: STD_LOGIC_VECTOR (1 downto 0);
	signal nrs1 	: STD_LOGIC_VECTOR (5 downto 0);
	signal nrs2 	: STD_LOGIC_VECTOR (5 downto 0);
	signal nrd	 	: STD_LOGIC_VECTOR (5 downto 0);
	signal r7	 	: STD_LOGIC_VECTOR (5 downto 0);
	
	

begin
	add_map : ADD port map(
		x"00000001", npci, addi
	);

	npc_map : PC port map(
		clk, reset, pc_out, npci
	);
	
	pc_map : PC port map(
		clk, reset, npci, pci
	);
		
	im_map : IM port map(
		reset, pci, im_o
	);
	
	op 	<= im_o(31 downto 30);
	op2 	<= im_o(24 downto 22);
	op3 	<= im_o(24 downto 19);
	cond 	<= im_o(28 downto 25);
	rd 	<= im_o(29 downto 25);
	rs1 	<= im_o(18 downto 14);
	i 		<= im_o(13);
	imm13 <= im_o(12 downto 0);
	rs2 	<= im_o(4 downto 0);
	disp22 <= im_o(21 downto 0);
	seu_disp30 <= "00"&im_o(29 downto 0);
	

	cu_map : CU port map(
		op, op2, op3, cond, nzvc, aluop, en_dm, we_dm, pc_src, we_rf, rf_src, rf_dtn
	);
	
	mux_RF_nrd_map: MUX_RF_NRD port map(
		nrd, r7, rf_dtn, out_nrd
	);
	
	rf_map : RF port map(
		clk, reset, nrs1, nrs2, out_nrd, we_rf, rf_data, crs1, crs2, crd
	);
	
	seu_map : SEU port map(
		imm13, imm31
	);
	
	seu_disp22_map : SEU22 port map(
		disp22, seu_disp22
	);
	
	add_disp22_map: ADD port map(
		pci, seu_disp22, pc_disp22
	);
	
	add_disp30_map: ADD port map(
		pci, seu_disp30, pc_disp30
	);
	
	mux_map : MUX port map(
		crs2, imm31, i, ope2
	);
	
	wm_map : WM port map(
		op, op3, cwp, rs1, rs2, rd, ncwp, nrs1, nrs2, nrd, r7
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
	
	mux_NPC_src_map: MUX_NPC_SRC port map(
		addi, pc_disp22, pc_disp30, alursi, pc_src, pc_out
	);
	
	dm_map: DM port map(
		clk, reset, alursi, en_dm, we_dm, crd, data
	);
	
	mux_RF_dwr_map: MUX_RF_DWR port map(
		data, alursi, pci, rf_src, rf_data
	);
	

end Behavioral;


