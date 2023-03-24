library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EX is
    Port (  ALUSrc : in STD_LOGIC;
         RegDst : in STD_LOGIC;
         ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
         func : in STD_LOGIC_VECTOR(2 downto 0);
         rd1: in STD_LOGIC_VECTOR(15 downto 0);
         rd2: in STD_LOGIC_VECTOR(15 downto 0);
         Ext_Imm : in STD_LOGIC_VECTOR(15 downto 0);
         PC_next : in STD_LOGIC_VECTOR(15 downto 0);
         zero : out STD_LOGIC;
         ALURes : out STD_LOGIC_VECTOR(15 downto 0);
         branch_address : out STD_LOGIC_VECTOR(15 downto 0);
         rt, rd : in STD_LOGIC_VECTOR(2 downto 0);
         wa : out STD_LOGIC_VECTOR(2 downto 0));
end EX;

architecture Behavioral of EX is
    signal ALUCtrl : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal mux1 : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    signal rezultat : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
begin

    process(ALUSrc, rd2, Ext_Imm) --mux1
    begin
        if ALUSrc = '0' then
            mux1 <= rd2;
        else
            mux1 <= Ext_Imm;
        end if;
    end process;

    process(ALUOp, func)
    begin
        case ALUOp is
            when "00" => ALUCtrl <= "000"; --addi, lw, sw
            when "01" => ALUCtrl <= "100"; --beq, j
            when "10" => ALUCtrl <= func; -- R
            when "11" => ALUCtrl <= "010"; -- ori
        end case;

    end process;


    process(rd1, mux1, ALUCtrl)
    begin
        case ALUCtrl is
            when "000" => rezultat <= rd1 + mux1; zero<='0'; --add
            when "001" => rezultat <= rd1 and mux1; zero<='0';   --and
            when "010" => rezultat <= mux1(14 downto 0) & "0"; zero<='0';  --sll
            when "011" => rezultat <= "0" & mux1(15 downto 1); zero<='0';   --srl
            when "100" => rezultat <= rd1 - mux1; zero<='0'; --sub
            when "101" => rezultat <= rd1 or mux1; zero<='0';    --or
            when "110" => rezultat <= rd1 xor mux1; zero<='0';  --xor
            when others => rezultat <= mux1(15) & mux1(15 downto 1);--sra   
            --if rd1= mux1 then zero <= '1';
              --  elsif rd1< mux1 then  rezultat <= x"0001";
               -- else rezultat <= x"0000";
               -- end if;
        end case;

        if rezultat = 0 then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;
    
    process(RegDst, rt, rd) -- mux writeaddress
    begin
        if regdst = '0' then
            wa <= rt;
        else
            wa <= rd;
        end if;
    end process;
    ALURes <= rezultat;
    branch_address <= PC_next + Ext_Imm;

end Behavioral;
