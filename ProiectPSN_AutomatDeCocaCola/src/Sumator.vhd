library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

entity SUMATOR is
	port(A,B: in unsigned(7 downto 0):="00000000";
	S:out unsigned(7 downto 0));
end entity SUMATOR;

architecture comp of SUMATOR is
begin 

	process(A,B)
	begin 
		
		S <= A+B;
	end process;
	end architecture comp;	 
	

