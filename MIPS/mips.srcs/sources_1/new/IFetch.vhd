library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IFetch is
    Port(clk: in std_logic;
         reset: in std_logic;
         enable: in std_logic;
         Jump: in std_logic;
         PCSrc: in std_logic;
         branch_address: in std_logic_vector(15 downto 0);
         jump_address: in std_logic_vector(15 downto 0);
         Instruction: out std_logic_vector(15 downto 0);
         PC_next: out std_logic_vector(15 downto 0));

end IFetch;

architecture Behavioral of IFetch is
    type ROM_Memory is array(0 to 255) of std_logic_vector(15 downto 0);
    signal ROM: ROM_Memory := (
        B"000_000_000_001_0_000",            -- 0. 0010   add $1, $0, $0 	
        B"001_000_010_000_1_010",            -- 1. 210A   addi $2, $0, 10
        B"000_000_000_011_0_000",            -- 2. 0030   add $3, $0, $0 
        B"000_000_000_100_0_000",            -- 3. 0040   add $4, $0, $0  	    
        B"001_000_110_000_0_001",            -- 4. 2301   addi $6, $0, 1 
        B"100_001_010_000_0_111",            -- 5. 8507   beq $1, $2, 7
        B"110_011_101_000_1_011",            -- 6. CE8B   lw $5, 11($3) 	
        B"000_110_101_111_0_101",            -- 7. 1AF5   and $7, $6, $5	
        B"100_101_111_000_0_001",            -- 8. 9781   beq $6, $7, 1   
        B"000_100_101_100_0_000",            -- 9. 12C0   add $4, $4, $5	    
        B"001_011_011_000_0_010",            --10. 2D82   addi $3, $3, 2  
        B"001_001_001_000_0_010",            --11. 2482   addi $1, $1, 2 
        B"010_000_000_000_0_101",            --12. 4005   j 5		        
        B"111_000_100_011_0_011",            --13. E233   sw $4, 51($0)		
        B"001_100_100_0000000"	,            --14. 3200  -- 1E
       others => B"000_000_000_000_0_110"); --            add $0, $0, $0);   
    signal mux1: std_logic_vector(15 downto 0) := x"0000";
    signal mux2: std_logic_vector(15 downto 0) := x"0000";
    signal pc: std_logic_vector(15 downto 0) := x"0000";
    signal pc_add: std_logic_vector(15 downto 0) := x"0000";
    signal en1: std_logic;
    signal en2: std_logic;
begin
    
    process(clk, reset, enable, pc)  --PC
    begin
        if (clk = '1' and clk'event) then
            if (reset = '1') then
                pc<= x"0000";
            elsif (enable = '1') then
                pc<=mux2;
            end if;
        end if;
    end process;

    process(pc)   --PC
    begin
        Instruction <= ROM(conv_integer(pc));
        pc_add <= pc + 1;
    end process;

    PC_next <= pc_add;

    process(pc, branch_address, PCSrc) --mux1
    begin
        case PCSrc is
            when '0' => mux1 <= pc_add;
            when '1' => mux1 <= branch_address;
        end case;
    end process;

    process(mux1, jump_address, Jump, pc) --mux2
    begin
        case Jump is
            when '0' => mux2 <= mux1;
            when '1' => mux2 <= jump_address;
        end case;
    end process;
end Behavioral;
