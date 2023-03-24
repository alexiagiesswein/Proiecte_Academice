library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
    port ( clk : in std_logic;
         we : in std_logic;
         ra : in std_logic_vector(15 downto 0);
         wa : in std_logic_vector(15 downto 0);
         wd : in std_logic_vector(15 downto 0); 
         rd : out std_logic_vector(15 downto 0)); 
end entity;

architecture Behavioral of RAM is
    type ram_type is array (0 to 15) of std_logic_vector (15 downto 0);
    signal RAM: ram_type := (
        x"0001",
        x"0002",
        x"0003",
        x"0004",
        x"0005",
        x"0006",
        x"0007",
        others => x"0000");
begin
    process (clk)
    begin
        if clk'event and clk = '1' then
            if we = '1' then
                    RAM(conv_integer(wa)) <= wd;
                else
                    rd <= RAM( conv_integer(ra));
                end if;
            end if;
    end process;

end Behavioral;
