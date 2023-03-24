library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity POARTA_SI8 is
	port(A,B: in std_logic_vector(7 downto 0);
	Y: out std_logic_vector(7 downto 0));
end entity POARTA_SI8;	   

architecture flux of POARTA_SI8 is
begin
	Y<= A and B;	 
end architecture flux;	
