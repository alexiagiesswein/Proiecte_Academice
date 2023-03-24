library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UC is
  Port ( Instructions: in std_logic_vector(2 downto 0);
         RegWrite: out std_logic;
         RegDst: out std_logic;
         ExtOp: out std_logic;
         ALUSrc: out std_logic;
         Branch: out std_logic;
         Jump: out std_logic;
         ALUOp: out std_logic_vector(1 downto 0);
         MemtoReg: out std_logic;
         MemWrite: out std_logic); 
end UC;

architecture Behavioral of UC is

begin
 process(Instructions)
    begin
        
        case Instructions is
        when "000"=> RegDst<='1';RegWrite<= '1'; ALUSrc<='0'; Branch<='0' ;MemtoReg<='0'; Jump<='0'; MemWrite<='0'; ExtOp<='0';ALUOp<="10"; --R
		when "001"=> RegDst<='0';RegWrite<= '1'; ALUSrc<='1';Branch<='0'; MemtoReg<='0'; Jump<='0'; MemWrite<='0'; ExtOp<='1';ALUOp<="00"; -- addi
		when "010"=> RegDst<='0';RegWrite<= '0'; ALUSrc<='0';Branch<='0'; MemtoReg<='0'; Jump<='1'; MemWrite<='0'; ExtOp<='0';ALUOp<="01";	--j
		when "011"=> RegDst<='0';RegWrite<= '1'; ALUSrc<='1';Branch<='0'; MemtoReg<='0'; Jump<='0'; MemWrite<='0'; ExtOp<='0';ALUOp<="11"; --ori
		
		when "100"=>RegDst<='0';RegWrite<= '0'; ALUSrc<='0';Branch<='1'; MemtoReg<='0'; Jump<='0'; MemWrite<='0'; ExtOp<='1';ALUOp<="01"; -- beq
		when "101"=>RegDst<='0';RegWrite<= '0'; ALUSrc<='0';Branch<='1'; MemtoReg<='0'; Jump<='0'; MemWrite<='0'; ExtOp<='0';ALUOp<="01"; -- bne
		when "110"=>RegDst<='0';RegWrite<= '1'; ALUSrc<='1';Branch<='0'; MemtoReg<='1'; Jump<='0'; MemWrite<='0'; ExtOp<='1';ALUOp<="00"; -- lw
		when "111"=>RegDst<='0';RegWrite<= '0'; ALUSrc<='1';Branch<='0'; MemtoReg<='0'; Jump<='0'; MemWrite<='1'; ExtOp<='1';ALUOp<="00"; -- sw

        end case;             
    end process;
   
  

end Behavioral;
