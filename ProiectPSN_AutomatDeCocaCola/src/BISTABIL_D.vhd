library IEEE; 
use IEEE.STD_LOGIC_1164.all; 

entity BISTABIL_D is
	port ( CLEAR, CLK : in std_logic;
	         D: in std_logic;
	         Q : out std_logic:='0');       
end BISTABIL_D;

architecture comp of BISTABIL_D is 
begin 

	process(CLK, D, CLEAR)
	begin
	   if CLEAR ='1' then Q <='0';
	   elsif CLK'event and CLK='1' then Q <= D;
	 
	   end if;
	end process;
end architecture; 


	  
			


