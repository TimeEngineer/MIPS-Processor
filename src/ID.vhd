library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL; 

-- Decodeur d'instructions
entity ID is port (
	instruction		: in std_logic_vector (31 downto 0);		-- 32 bits instruction
	PSR				: in std_logic_vector (31 downto 0);		-- Load command
	nPCSel			: out std_logic;							-- PC select
	RegWr			: out std_logic;							-- Register write enable
	ALUSrc			: out std_logic;							-- ALU source
	ALUCtr			: out std_logic_vector (1 downto 0);		-- ALU control
	PSREn			: out std_logic;							-- PSR enable
	MemWr			: out std_logic;							-- Memory write enable
	WrSrc			: out std_logic;							-- Write source
	RegSel			: out std_logic;							-- Register select
	Rn				: out std_logic_vector (3 downto 0);		-- Bus address N
	Rd				: out std_logic_vector (3 downto 0);		-- Bus address D
	Rm				: out std_logic_vector (3 downto 0);		-- Bus address M
	Imm				: out std_logic_vector (7 downto 0);		-- Immediate
	Offset			: out std_logic_vector (23 downto 0));		-- Offset
end entity; 

architecture behav of ID is

	type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);

	signal instr_courante : enum_instruction;

begin
process(instruction, PSR) begin
	if std_match(instruction, "1110001110100000----000---------") then instr_courante <= MOV;
	elsif std_match(instruction, "111000101000--------0000--------") then instr_courante <= ADDi;
	elsif std_match(instruction, "111000001000--------00000000----") then instr_courante <= ADDr;
	elsif std_match(instruction, "111000110101----00000000--------") then instr_courante <= CMP;
	elsif std_match(instruction, "111001100001--------------------") then instr_courante <= LDR;
	elsif std_match(instruction, "111001100000--------------------") then instr_courante <= STR;
	elsif std_match(instruction, "11101010------------------------") then instr_courante <= BAL;
	elsif std_match(instruction, "10111010------------------------") then instr_courante <= BLT;
	end if;
end process;

process(instruction, PSR) begin

	case instr_courante is
		when MOV =>
			nPCSel <= '0';
			RegWr <= '1';
			ALUSrc <= '1';
			ALUCtr <= "01";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Rd <= instruction(15 downto 12);
			Imm <= instruction(7 downto 0);

		when ADDi =>
			nPCSel <= '0';
			RegWr <= '1';
			ALUSrc <= '0';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Rn <= instruction(19 downto 16);
			Rd <= instruction(15 downto 12);
			Imm <= instruction(7 downto 0);

		when ADDr =>
			nPCSel <= '0';
			RegWr <= '1';
			ALUSrc <= '1';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Rn <= instruction(19 downto 16);
			Rd <= instruction(15 downto 12);
			Rm <= instruction(3 downto 0);

		when CMP =>
			nPCSel <= '0';
			RegWr <= '0';
			ALUSrc <= '1';
			ALUCtr <= "10";
			PSREn <= '1';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Rn <= instruction(19 downto 16);
			Imm <= instruction(7 downto 0);

		when LDR =>
			nPCSel <= '0';
			RegWr <= '1';
			ALUSrc <= '1';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '1';
			RegSel <= '0';
			Rn <= instruction(19 downto 16);
			Rd <= instruction(15 downto 12);
			Imm <= instruction(7 downto 0);

		when STR =>
			nPCSel <= '0';
			RegWr <= '0';
			ALUSrc <= '1';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '1';
			WrSrc <= 'X';
			RegSel <= '1';
			Rn <= instruction(19 downto 16);
			Rd <= instruction(15 downto 12);
			Imm <= instruction(7 downto 0);

		when BAL =>
			nPCSel <= '1';
			RegWr <= '0';
			ALUSrc <= '0';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Offset <= instruction(23 downto 0);

		when BLT =>
			nPCSel <= '1';
			RegWr <= '0';
			ALUSrc <= '0';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Offset <= instruction(23 downto 0);
	end case;
end process;
end behav;
