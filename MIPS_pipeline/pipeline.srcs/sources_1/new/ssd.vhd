library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ssd is
    Port (
        clk    : in  STD_LOGIC;
        digit0 : in  STD_LOGIC_VECTOR(3 downto 0);
        digit1 : in  STD_LOGIC_VECTOR(3 downto 0);
        digit2 : in  STD_LOGIC_VECTOR(3 downto 0);
        digit3 : in  STD_LOGIC_VECTOR(3 downto 0);
        cat    : out STD_LOGIC_VECTOR(6 downto 0);
        an     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end ssd;

architecture Behavioral of ssd is

    signal counter : std_logic_vector(15 downto 0) := X"0000";
    signal mux : std_logic_vector(3 downto 0)  := X"0";

begin

   process(clk)
    begin
        if clk'event and clk = '1' then
            counter <= counter + 1;
        end if;
    end process; -- counter


    process(counter(15 downto 14), digit0, digit1, digit2, digit3)
    begin
        case counter(15 downto 14) is
            when "00" => mux <= digit3;
            when "01" => mux <= digit2;
            when "10" => mux <= digit1;
            when "11" => mux <= digit0;
            when others => mux <= digit3;
        end case;
    end process; -- mux1

    process(counter(15 downto 14))
    begin
        case counter(15 downto 14) is
            when "00" => an <= "1110";
            when "01" => an <= "1101";
            when "10" => an <= "1011";
            when "11" => an <= "0111";
            when others => an <= "1110";
        end case;
    end process; -- mux2

    -- segment encoding for the cathode (cat)
    --      0
    --     ---
    --  5 |   | 1
    --     ---   <- 6
    --  4 |   | 2
    --     ---
    --      3
    --
    -- Uses negative logic, so if the value is 0, it will light up
    --
    -- So the number 1 (one) would be 111_1001
    --                                ^^^ ^^^^
    --                                654_3210                                 

    process(mux)
    begin
        case mux is
            when "0001" => cat <= B"111_1001"; -- 1
            when "0010" => cat <= B"010_0100"; -- 2
            when "0011" => cat <= B"011_0000"; -- 3
            when "0100" => cat <= B"001_1001"; -- 4
            when "0101" => cat <= B"001_0010"; -- 5
            when "0110" => cat <= B"000_0010"; -- 6
            when "0111" => cat <= B"111_1000"; -- 7
            when "1000" => cat <= B"000_0000"; -- 8
            when "1001" => cat <= B"001_0000"; -- 9
            when "1010" => cat <= B"000_1000"; -- A
            when "1011" => cat <= B"000_0011"; -- b
            when "1100" => cat <= B"100_0110"; -- C
            when "1101" => cat <= B"010_0001"; -- d
            when "1110" => cat <= B"000_0110"; -- E
            when "1111" => cat <= B"000_1110"; -- F
            when others => cat <= B"100_0000"; -- 0
        end case;
    end process; -- decoder

end Behavioral;