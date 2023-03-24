library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

entity PROIECT is
	port(F0,F1,F2,FS,B: in std_logic;
	CLK: in std_logic;
	F3,DC: out std_logic;
	REST: out unsigned(7 downto 0);
	F4,RS,AT,RM: inout std_logic;
	R: inout unsigned(7 downto 0):="00000000");
end entity PROIECT;	 


architecture struct of PROIECT is
signal F,L: std_logic;				   --F=F0+F1+F2, L=F1+F2, AT+RS=DC
signal M,Suma:  unsigned(7 downto 0):="00000000";	 --M-moneda introdusa, R-suma din registru, Mic-suma care se returneaza	
signal C:unsigned(7 downto 0):="01100100";	 --C=constanta 100
signal I1,I2,I3: std_logic_vector(7 downto 0); --I1=Suma si RS*8, I2=C si RS*8, I3=R si B*8
signal D0,D1,D2,D3,D4,D5,D6,D7,I4,I5,I6: std_logic:='0';
signal CON:unsigned(7 downto 0):="00000000";

begin
	
	Poarta_SAU3: entity work.Poarta_SAU3 port map(A => F0, B => F1, CIN => F2, COUT =>F);
		
	Poarta_SI: entity work.Poarta_SI port map(A => F, B => FS, Y =>F4);	 --F4=1 moneda este acceptata
	Poarta_NOT: entity work.Poarta_NOT port map( A => F4, Y => F3);		 --F3=1 moneda este respinsa
		
	Poarta_si2:entity work.Poarta_SI port map(A =>F4 , B => F2, Y =>M(5));	--calculam M-moneda introdusa
	Poarta_si3:entity work.Poarta_SI port map(A => F4, B => F2, Y =>M(4));
	Poarta_si4:entity work.Poarta_SI port map(A => F4, B => F1, Y =>M(3));
	Poarta_si5:entity work.Poarta_SI port map(A => F4, B => F0, Y =>M(2));
	Poarta_SAU1: entity work.Poarta_SAU port map(A => F1, B => F2, COUT =>L);	
	Poarta_si6:entity work.Poarta_SI port map(A => F4, B => L, Y =>M(1));
	Poarta_si7:entity work.Poarta_SI port map(A => F4, B => F0, Y =>M(0));
		
	SUMATOR: entity work.SUMATOR port map( A => R, B => M, S =>Suma);
		
	COMPARATOR: entity work.COMPARATOR port map( A => Suma, B => C, F1 =>RS, F2 =>AT, F3 =>RM);
	Poarta_SAU2: entity work.Poarta_SAU port map(A => AT, B => RS, COUT =>DC);					  --DC=1-se elibereaza cola
	
	Poarta_SI8_1: entity work.Poarta_SI8 port map(A(0) => RS, A(1) => RS, A(2) => RS, A(3) => RS, A(4) => RS, A(5) => RS, A(6) => RS, A(7) => RS, B(0) => Suma(0),	--se elibereaza rest(daca suma e mai mare)
		B(1) => Suma(1), B(2) => Suma(2), B(3) => Suma(3), B(4) => Suma(4), B(5) => Suma(5), B(6) => Suma(6), B(7) => Suma(7), Y =>I1);
	Poarta_SI8_2: entity work.Poarta_SI8 port map(A(0) => RS, A(1) => RS, A(2) => RS, A(3) => RS, A(4) => RS, A(5) => RS, A(6) => RS, A(7) => RS, B(0) => C(0),
		B(1) => C(1), B(2) => C(2), B(3) => C(3), B(4) => C(4), B(5) => C(5), B(6) => C(6), B(7) => C(7), Y =>I2);
	SCAZATOR: entity work.SCAZATOR port map( A(0) => I1(0),  A(1) => I1(1), A(2) => I1(2), A(3) => I1(3), A(4) => I1(4), A(5) => I1(5), A(6) => I1(6), A(7) => I1(7),
		B(0)=> I2(0), B(1) => I2(1), B(2) => I2(2), B(3) => I2(3), B(4) => I2(4), B(5) => I2(5), B(6) => I2(6), B(7) => I2(7), S =>REST);
	
	
	Poarta_SI_0: entity work.Poarta_SI port map(A => Suma(0), B => RM, Y =>D0);						--punem suma anterioara in registru
	BISTABIL_D_0: entity work.BISTABIL_D port map(CLEAR => I4, CLK => CLK, D=>D0, Q =>R(0));
		
	Poarta_SI_1: entity work.Poarta_SI port map(A => Suma(1), B => RM, Y =>D1);
	BISTABIL_D_1: entity work.BISTABIL_D port map(CLEAR => I4, CLK => CLK, D=>D1, Q =>R(1));
		
	Poarta_SI_2: entity work.Poarta_SI port map(A => Suma(2), B => RM, Y =>D2);
	BISTABIL_D_2: entity work.BISTABIL_D port map(CLEAR => I4, CLK => CLK, D=>D2, Q =>R(2));
		
	Poarta_SI_3: entity work.Poarta_SI port map(A => Suma(3), B => RM, Y =>D3);
	BISTABIL_D_3: entity work.BISTABIL_D port map(CLEAR => I4, CLK => CLK, D=>D3, Q =>R(3));
		
	Poarta_SI_4: entity work.Poarta_SI port map(A => Suma(4), B => RM, Y =>D4);
	BISTABIL_D_4: entity work.BISTABIL_D port map(CLEAR => I4, CLK => CLK, D=>D4, Q =>R(4));
		
	Poarta_SI_5: entity work.Poarta_SI port map(A => Suma(5), B => RM, Y =>D5);
	BISTABIL_D_5: entity work.BISTABIL_D port map(CLEAR => I4, CLK => CLK, D=>D5, Q =>R(5));
		
	Poarta_SI_6: entity work.Poarta_SI port map(A => Suma(6), B => RM, Y =>D6);
	BISTABIL_D_6: entity work.BISTABIL_D port map(CLEAR => I4, CLK => CLK, D=>D6, Q =>R(6));
		
	Poarta_SI_7: entity work.Poarta_SI port map(A => Suma(7), B => RM, Y =>D7);
	BISTABIL_D_7: entity work.BISTABIL_D port map(CLEAR => I4, CLK => CLK, D=>D7, Q =>R(7));
	
	Poarta_SI8_3: entity work.Poarta_SI8 port map(A(0) => B, A(1) => B, A(2) => B, A(3) => B, A(4) => B, A(5) => B, A(6) => B, A(7) => B, B(0) => R(0),	--daca suma e mai mica decat 1 leu, se returneaza I3=R
		B(1) => R(1), B(2) => R(2), B(3) => R(3), B(4) => R(4), B(5) => R(5), B(6) => R(6), B(7) => R(7), Y =>I3);
		
	COMPARATOR2: entity work.COMPARATOR port map( A(0) => I3(0), A(1) => I3(1), A(2) => I3(2), A(3) => I3(3), A(4) => I3(4), A(5) => I3(5), A(6) => I3(6), A(7) => I3(7), B => CON, F1 =>I4, F2 =>I5, F3 =>I6);
	
	
						
end architecture;