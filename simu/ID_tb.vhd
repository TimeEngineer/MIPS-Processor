library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Decodeur d'instructions
entity ID_tb is
	
end entity; 

architecture bench of ID_tb is

	signal instruction_tb : std_logic_vector (31 downto 0);
	signal PSR_tb : std_logic_vector (31 downto 0);
	signal nPCSel_tb : std_logic;
	signal RegWr_tb : std_logic;
	signal ALUSrc_tb : std_logic;
	signal ALUCtr_tb : std_logic_vector (1 downto 0);
	signal PSREn_tb : std_logic;
	signal MemWr_tb : std_logic;
	signal WrSrc_tb : std_logic;
	signal RegSel_tb : std_logic;
	signal Rn_tb : std_logic_vector (3 downto 0);
	signal Rd_tb : std_logic_vector (3 downto 0);
	signal Rm_tb : std_logic_vector (3 downto 0);
	signal Imm_tb : std_logic_vector (7 downto 0);
	signal Offset_tb : std_logic_vector (23 downto 0);

begin

	UUT1: entity work.id(behav) port map(
	instruction => instruction_tb,
	PSR => PSR_tb,
	nPCSel => nPCSel_tb,
	RegWr => RegWr_tb,
	ALUSrc => ALUSrc_tb,
	ALUCtr => ALUCtr_tb,
	PSREn => PSREn_tb,
	MemWr => MemWr_tb,
	WrSrc => WrSrc_tb,
	RegSel => RegSel_tb,
	Rn => Rn_tb,
	Rd => Rd_tb,
	Rm => Rm_tb,
	Imm => Imm_tb,
	Offset => Offset_tb);

stimulus: process begin
	wait for 10 ns;
	instruction_tb <= x"E3A01020";
	wait for 50 ns;
	instruction_tb <= x"E3A02000";
	wait for 50 ns;
	instruction_tb <= "11100110000100010000000000000000";
	wait for 50 ns;
	instruction_tb <= x"E0822000";
	wait for 50 ns;
	instruction_tb <= x"E2811001";
	wait for 50 ns;
	instruction_tb <= x"E351002A";
	wait for 50 ns;
	instruction_tb <= x"BAFFFFFB";
	wait for 50 ns;
	instruction_tb <= x"E6012000";
	wait for 50 ns;
	instruction_tb <= x"EAFFFFF7";
	wait  for 40 ns;

	end process stimulus;
end bench;