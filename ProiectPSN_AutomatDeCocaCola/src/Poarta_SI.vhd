library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity POARTA_SI is
	port(A,B: in std_logic;
	Y: out std_logic);
end entity POARTA_SI;	   

architecture flux of POARTA_SI is
begin
	Y<= A and B;	 
end architecture flux;	



