library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity POARTA_SAU3 is
	port(A,B,CIN: in std_logic;
	COUT: out std_logic);
end entity POARTA_SAU3;	 

architecture flux of POARTA_SAU3 is
begin
	COUT <= A or B or CIN;
	end architecture flux;