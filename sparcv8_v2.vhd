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

entity sparcv8_v2 is
	Port ( 
		clk 	: in  STD_LOGIC;
		reset : in  STD_LOGIC;
		alurs : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end sparcv8_v2;

architecture Behavioral of sparcv8_v2 is

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
			rs1 	: in  STD_LOGIC_VECTOR (4 downto 0);
			rs2 	: in  STD_LOGIC_VECTOR (4 downto 0);
			rd 	: in  STD_LOGIC_VECTOR (4 downto 0);
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

	-- signals
	
	signal add_o : std_logic_vector(31 downto 0);
	signal npc_o : std_logic_vector(31 downto 0);
	
	signal pc_o : std_logic_vector(31 downto 0);
	
	signal im_o : std_logic_vector(31 downto 0);
	
	signal cu_o : std_logic_vector(5 downto 0);
	
	signal crs1_i : std_logic_vector(31 downto 0);
	signal crs2_i : std_logic_vector(31 downto 0);
	
	signal seu_o : std_logic_vector(31 downto 0);
	
	signal mux_o : std_logic_vector(31 downto 0);
	
	signal alurs_i : std_logic_vector(31 downto 0);


begin
	add_map : ADD port map(
		x"00000001", npc_o, add_o
	);

	npc_map : PC port map(
		clk, reset, add_o, npc_o
	);
	
	pc_map : PC port map(
		clk, reset, npc_o, pc_o
	);
	
	im_map : IM port map(
		reset, pc_o, im_o
	);
	
	cu_map : CU port map(
		im_o(31 downto 30), im_o(24 downto 19), cu_o
	);
	
	rf_map : RF port map(
		clk, reset, im_o(18 downto 14), im_o(4 downto 0), im_o(29 downto 25), '1', alurs_i, crs1_i, crs2_i
	);
	
	seu_map : SEU port map(
		im_o(12 downto 0), seu_o
	);
	
	mux_map : MUX port map(
		crs2_i, seu_o, im_o(13), mux_o
	);
	
	alu_map : ALU port map(
		crs1_i, mux_o, cu_o, '0', alurs_i
	);
	
	alurs <= alurs_i;

end Behavioral;

