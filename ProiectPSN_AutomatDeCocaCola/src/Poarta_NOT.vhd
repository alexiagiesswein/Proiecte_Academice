library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity POARTA_NOT is
	port(A: in std_logic;
	Y: out std_logic);
end entity POARTA_NOT;	   

architecture flux of POARTA_NOT is
begin
	Y<= not A;	 
end architecture flux;