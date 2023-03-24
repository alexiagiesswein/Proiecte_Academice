library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WB is
    Port ( ALUZero: in STD_LOGIC;
         Branch: in STD_LOGIC;
         MemtoReg: in STD_LOGIC;
         Instruction: in STD_LOGIC_VECTOR(12 downto 0);
         ALURes: in STD_LOGIC_VECTOR(15 downto 0);
         MemData: in STD_LOGIC_VECTOR(15 downto 0);
         PC_next: in STD_LOGIC_VECTOR(15 downto 0);
         PCSrc: out STD_LOGIC;
         jump_address: out STD_LOGIC_VECTOR(15 downto 0);
         wd:  out STD_LOGIC_VECTOR(15 downto 0));
end WB;

architecture Behavioral of WB is
begin
    PCSrc <= ALUZero and Branch;
    jump_address <= PC_next(15 downto 13) & Instruction;
    with MemtoReg select wd <=
        MemData when '1',
        ALURes when '0';

end Behavioral;
