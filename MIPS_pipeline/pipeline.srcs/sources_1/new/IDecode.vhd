library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IDecode is
    port( clk: in std_logic;
         en: in std_logic;
         Instr: in std_logic_vector(15 downto 0);
         wd: in std_logic_vector(15 downto 0);
         RegWrite: in std_logic;
         RegDst: in std_logic;
         ExtOp: in std_logic;
         rd1: out std_logic_vector(15 downto 0);
         rd2: out std_logic_vector(15 downto 0);
         Ext_Imm: out std_logic_vector(15 downto 0);
         func: out std_logic_vector(2 downto 0);
         sa: out std_logic;
         wa: in std_logic_vector(2 downto 0);
         rt: out std_logic_vector(2 downto 0);
         rd: out std_logic_vector(2 downto 0);
         rs: out std_logic_vector(2 downto 0));
end IDecode;

architecture Behavioral of IDecode is
    component reg_file
        Port (
            clk : in std_logic;
            ra1 : in std_logic_vector (2 downto 0);
            ra2 : in std_logic_vector (2 downto 0);
            wa : in std_logic_vector (2 downto 0);
            wd : in std_logic_vector (15 downto 0);
            wen : in std_logic;
            rd1 : out std_logic_vector (15 downto 0);
            rd2 : out std_logic_vector (15 downto 0)

        );
    end component;
    signal WriteAddress: std_logic_vector(2 downto 0);
begin

    reg_file1 : reg_file   --Reg_file
        port map(
            clk => clk,
            ra1 => Instr(12 downto 10),
            ra2 => Instr(9 downto 7),
            wa  => wa,
            wd => wd,
            wen => RegWrite,
            rd1 => rd1,
            rd2 => rd2);

    process(ExtOp, Instr(6 downto 0))  --Ext_Unit
    begin
        if ExtOp = '1' and Instr(6) = '1' then
            Ext_Imm <= "111111111" & Instr(6 downto 0);
        else
            Ext_Imm <= "000000000" & Instr(6 downto 0);
        end if;
    end process;

    process(RegDst, Instr(9 downto 4))  --Mux
    begin
        if RegDst = '0' then
            WriteAddress <= Instr(9 downto 7);
        else
            WriteAddress <= Instr(6 downto 4);
        end if;
    end process;

    func <= Instr(2 downto 0);
    rs <= Instr(12 downto 10);
    rt <= Instr(9 downto 7);
    rd <= Instr(6 downto 4);


end Behavioral;


