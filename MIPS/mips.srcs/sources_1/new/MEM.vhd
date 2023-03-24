library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEM is
    Port (MemWrite : in STD_LOGIC;
         clk: in STD_LOGIC;
         en : in STD_LOGIC;
         rd2 : in STD_LOGIC_VECTOR(15 downto 0);
         ALURes : inout STD_LOGIC_VECTOR(15 downto 0);
         MemData : out STD_LOGIC_VECTOR(15 downto 0));
end MEM;

architecture Behavioral of MEM is
    type ram_type is array(0 to 65535) of STD_LOGIC_VECTOR(15 downto 0);
    signal ram : ram_type := (x"0000",
                              x"0000",
                              x"0000",
                              x"0000",
                              x"0000",
                              x"0000",
                              x"0000",
                              x"0000",
                              x"0000",
                              x"0000",
                              x"0000",
                              x"0003",
                              x"0005",
                              x"0008",
                              x"0009",
                              x"000C",
                              x"0002",
                              x"0006",
                              x"000B",
                              x"0004",
                              x"000D",
                              others => x"0000");
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if MemWrite = '1' then
                if en = '1' then
                    ram(conv_integer(ALURes)) <= rd2;
                end if;
            end if;
            MemData <= ram(conv_integer(ALURes));
        end if;
    end process;

end Behavioral;
