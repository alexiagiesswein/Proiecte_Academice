library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity POARTA_SAU is
	port(A,B: in std_logic;
	COUT: out std_logic);
end entity POARTA_SAU;	 

architecture flux of POARTA_SAU is
begin
	COUT <= A or B;
	end architecture flux;