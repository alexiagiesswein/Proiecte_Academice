library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

entity COMPARATOR is
	port(A,B: in unsigned(7 downto 0);
	F1,F2,F3:out std_logic);
end entity COMPARATOR;


architecture comp of COMPARATOR is
begin 
	process(A,B)
	begin
		if A>B then F1<='1'; F2<='0'; F3<='0';
		elsif A=B then F1<='0'; F2<='1'; F3<='0';
		elsif A<B then F1<='0'; F2<='0'; F3<='1';	
		end if;
		end process;
	end architecture comp;