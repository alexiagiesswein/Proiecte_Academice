library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_env is
    Port ( clk : in STD_LOGIC;
         btn : in STD_LOGIC_VECTOR (4 downto 0);
         sw : in STD_LOGIC_VECTOR (15 downto 0);
         led : out STD_LOGIC_VECTOR(15 downto 0);
         an : out STD_LOGIC_VECTOR(3 downto 0);
         cat : out STD_LOGIC_VECTOR(6 downto 0));
end test_env;

architecture Behavioral of test_env is
    component mpg
        Port(en: out  STD_LOGIC;
             input: in STD_LOGIC;
             clock : in  STD_LOGIC);
    end component;

    component ssd
        Port (
            clk    : in  STD_LOGIC;
            digit0 : in  STD_LOGIC_VECTOR(3 downto 0);
            digit1 : in  STD_LOGIC_VECTOR(3 downto 0);
            digit2 : in  STD_LOGIC_VECTOR(3 downto 0);
            digit3 : in  STD_LOGIC_VECTOR(3 downto 0);
            cat    : out STD_LOGIC_VECTOR(6 downto 0);
            an     : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    --    component reg_file
    --        Port (
    --            clk : in std_logic;
    --            ra1 : in std_logic_vector (15 downto 0);
    --            ra2 : in std_logic_vector (15 downto 0);
    --            wa : in std_logic_vector (15 downto 0);
    --            wd : in std_logic_vector (15 downto 0);
    --            wen : in std_logic;
    --            rd1 : out std_logic_vector (15 downto 0);
    --            rd2 : out std_logic_vector (15 downto 0)
    --        );
    --    end component;


    component RAM
        Port(
            clk : in std_logic;
            we : in std_logic;
            ra : in std_logic_vector(15 downto 0);
            wa : in std_logic_vector(15 downto 0);
            wd : in std_logic_vector(15 downto 0);
            rd : out std_logic_vector(15 downto 0));
    end component;

    component IFetch
        Port(clk: in std_logic;
             reset: in std_logic;
             enable: in std_logic;
             Jump: in std_logic;
             PCSrc: in std_logic;
             branch_address: in std_logic_vector(15 downto 0);
             jump_address: in std_logic_vector(15 downto 0);
             Instruction: out std_logic_vector(15 downto 0);
             PC_next: out std_logic_vector(15 downto 0));
    end component;

    component IDecode
        port( clk: in std_logic;
             en: in std_logic;
             Instr: in std_logic_vector(15 downto 0);
             wd: in std_logic_vector(15 downto 0);
             RegWrite: in std_logic;
             RegDst: in std_logic;
             ExtOp: in std_logic;
             rd1: out std_logic_vector(15 downto 0);
             rd2: out std_logic_vector(15 downto 0);
             Ext_Imm: out std_logic_vector(15 downto 0);
             func: out std_logic_vector(2 downto 0);
             sa: out std_logic;
             wa: in std_logic_vector(2 downto 0);
             rt: out std_logic_vector(2 downto 0);
             rd: out std_logic_vector(2 downto 0);
             rs: out std_logic_vector(2 downto 0));
    end component;

    component UC
        Port ( Instructions: in std_logic_vector(2 downto 0);
             RegWrite: out std_logic;
             RegDst: out std_logic;
             ExtOp: out std_logic;
             ALUSrc: out std_logic;
             Branch: out std_logic;
             Jump: out std_logic;
             ALUOp: out std_logic_vector(1 downto 0);
             MemtoReg: out std_logic;
             MemWrite: out std_logic);
    end component;

    component EX
        Port (  ALUSrc : in STD_LOGIC;
             RegDst : in STD_LOGIC;
             ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
             func : in STD_LOGIC_VECTOR(2 downto 0);
             rd1: in STD_LOGIC_VECTOR(15 downto 0);
             rd2: in STD_LOGIC_VECTOR(15 downto 0);
             Ext_Imm : in STD_LOGIC_VECTOR(15 downto 0);
             PC_next : in STD_LOGIC_VECTOR(15 downto 0);
             zero : out STD_LOGIC;
             ALURes : out STD_LOGIC_VECTOR(15 downto 0);
             branch_address : out STD_LOGIC_VECTOR(15 downto 0);
             rt, rd : in STD_LOGIC_VECTOR(2 downto 0);
             wa : out STD_LOGIC_VECTOR(2 downto 0));
    end component;


    component MEM
        Port (MemWrite : in STD_LOGIC;
             clk: in STD_LOGIC;
             en : in STD_LOGIC;
             rd2 : in STD_LOGIC_VECTOR(15 downto 0);
             ALURes : inout STD_LOGIC_VECTOR(15 downto 0);
             MemData : out STD_LOGIC_VECTOR(15 downto 0));
    end component;


    component WB
        Port ( ALUZero: in STD_LOGIC;
             Branch: in STD_LOGIC;
             MemtoReg: in STD_LOGIC;
             Instruction: in STD_LOGIC_VECTOR(12 downto 0);
             ALURes: in STD_LOGIC_VECTOR(15 downto 0);
             MemData: in STD_LOGIC_VECTOR(15 downto 0);
             PC_next: in STD_LOGIC_VECTOR(15 downto 0);
             PCSrc: out STD_LOGIC;
             jump_address: out STD_LOGIC_VECTOR(15 downto 0);
             wd:  out STD_LOGIC_VECTOR(15 downto 0));
    end component;


    signal cnt : std_logic_vector(15 downto 0) := x"0000";
    signal digit: std_logic_vector(15 downto 0);

    signal cc : std_logic_vector(7 downto 0) :=x"00";
    signal do : std_logic_vector(15 downto 0);

    signal rdd1, rdd2 : std_logic_vector (15 downto 0);
    signal wr : std_logic;

    signal  PC_next, wd,  ALURes, branch_address, jump_address, MemData: std_logic_vector(15 downto 0) := x"0000";
    signal PCSrc, ALUZero : std_logic;

    signal Instruction, PCinc, sum, rd1, rd2, Ext_imm, Ext_func, Ext_sa:std_logic_vector(15 downto 0);
    signal func, wa: std_logic_vector(2 downto 0);
    signal sa: std_logic;
    signal digits: std_logic_vector(15 downto 0);
    signal en1, en2, rst: std_logic;

    signal RegDst, ExtOp, ALUSrc, Branch, Jump, MemWrite, MemtoReg, RegWrite: std_logic;
    signal ALUOp: std_logic_vector(1 downto 0);
    signal rt, rd, rs : std_logic_vector(2 downto 0);

    signal IF_ID_pc, IF_ID_instruction: std_logic_vector(15 downto 0);

    signal ID_EX_memtoreg, ID_EX_regwrite,ID_EX_memwrite,ID_EX_branch, ID_EX_alusrc, ID_EX_regdst: std_logic;
    signal ID_EX_aluop: std_logic_vector(1 downto 0);
    signal ID_EX_pc, ID_EX_rd1, ID_EX_rd2, ID_EX_extimm: std_logic_vector(15 downto 0);
    signal ID_EX_rt, ID_EX_rd, ID_EX_func, ID_EX_rs: std_logic_vector(2 downto 0);

    signal EX_MEM_memtoreg, EX_MEM_regwrite, EX_MEM_memwrite, EX_MEM_branch, EX_MEM_aluzero: std_logic;
    signal EX_MEM_branchaddress, EX_MEM_alures, EX_MEM_rd2: std_logic_vector(15 downto 0);
    signal EX_MEM_writeaddress: std_logic_vector(2 downto 0);

    signal MEM_WB_memtoreg, MEM_WB_regwrite: std_logic;
    signal MEM_WB_memdata, MEM_WB_alures:std_logic_vector(15 downto 0);
    signal MEM_WB_writeaddress: std_logic_vector(2 downto 0);


begin
    mpg1: mpg
        port map(
            en => en1,
            input => btn(0) ,
            clock => clk);

    mpg2: mpg
        port map(
            en => en2,
            input => btn(1),
            clock => clk);
    ssd1: ssd
        port map(
            clk => clk,
            digit0 => digits(15 downto 12),
            digit1 => digits(11 downto 8),
            digit2 => digits(7 downto 4),
            digit3 => digits(3 downto 0),
            cat => cat,
            an => an
        );

    --    reg_file1 : reg_file
    --        port map(
    --            clk => clk,
    --            ra1 => cnt,
    --            ra2 => cnt,
    --            wa  => cnt,
    --            wd => sum,
    --            wen => wr,
    --            rd1 => rdd1,
    --            rd2 => rdd2);

    ram1 : RAM
        port map(
            clk => clk,
            we => wr,
            ra => cnt,
            wa => cnt,
            wd => rdd1,
            rd => rdd2);

    IFetch1: IFetch
        port map(clk => clk,
                 reset => en1,
                 enable => en2,
                 Jump => Jump,
                 PCSrc => PCSrc,
                 branch_address => EX_MEM_branchaddress,
                 jump_address => jump_address,
                 Instruction => Instruction,
                 PC_next => PC_next);

    PCSrc <= EX_MEM_aluzero and EX_MEM_branch;
    jump_address <= "000" & IF_ID_instruction(12 downto 0);

    --    IDecode1: IDecode
    --        port map(clk => clk,
    --                 en => en2,
    --                 RegWrite => RegWrite and en2,
    --                 RegDst => RegDst,
    --                 ExtOp => ExtOp,
    --                 Instr => Instruction,
    --                 wd => wd,
    --                 func => Instruction(2 downto 0),
    --                 rd1 => rd1,
    --                 rd2 => rd2,
    --                 Ext_Imm => Ext_Imm);

    process(clk)
    begin
        if rising_edge(clk) then
            if en2='1' then
                IF_ID_pc <= PC_next;
                IF_ID_instruction<= Instruction;
            end if;
        end if;
    end process;

    IDecode1: IDecode
        port map(clk => clk,
                 en => en2,
                 RegWrite => MEM_WB_regwrite and en2,
                 RegDst => RegDst,
                 ExtOp => ExtOp,
                 Instr => IF_ID_instruction,
                 wd => wd,
                 func => func, --Instruction(2 downto 0),
                 rd1 => rd1,
                 rd2 => rd2,
                 Ext_Imm => Ext_Imm,
                 wa => MEM_WB_writeaddress,
                 rt => rt,
                 rd => rd,
                 rs => rs );

    UC1: UC
        port map( Instructions => IF_ID_instruction(15 downto 13),
                 RegWrite => RegWrite,
                 RegDst => RegDst,
                 ExtOp => ExtOp,
                 ALUSrc => ALUSrc,
                 Branch => Branch,
                 Jump => Jump,
                 ALUOp => ALUOp,
                 MemtoReg => MemtoReg,
                 MemWrite => MemWrite);




    process(clk)  -- ID/EX
    begin
        if rising_edge(clk) then
            if en2= '1' then
                ID_EX_memtoreg<=MemtoReg;
                ID_EX_regdst <= RegDst;
                ID_EX_regwrite<=RegWrite;
                ID_EX_memwrite<=MemWrite;
                ID_EX_branch<=Branch;
                ID_EX_aluop<=ALUOp;
                ID_EX_alusrc<=ALUSrc;
                ID_EX_regdst<=RegDst;
                ID_EX_pc<=IF_ID_pc;--PC_next;
                ID_EX_rt<=IF_ID_instruction(9 downto 7);--Instruction;
                ID_EX_rd <= IF_ID_instruction(6 downto 4);
                ID_EX_rs <= rs;
                ID_EX_rd1<=RD1;
                ID_EX_rd2<=RD2;
                ID_EX_extimm<=Ext_imm;
                ID_EX_func <= func; -- Instruction(2 downto 0);
            end if;
        end if;
    end process;




    --    EX1: EX
    --        port map(ALUSrc => ALUSrc,
    --                 ALUOp => ALUOp,
    --                 func => Instruction(2 downto 0),
    --                 rd1 => rd1,
    --                 rd2 => rd2,
    --                 Ext_Imm => Ext_Imm,
    --                 PC_next => PC_next,
    --                 zero => ALUZero,
    --                 ALURes => ALURes,
    --                 branch_address => branch_address);

    EX1: EX
        port map(ALUSrc => ID_EX_alusrc,
                 RegDst => ID_EX_regdst,
                 ALUOp => ID_EX_aluop,
                 func => ID_EX_func,
                 rd1 => ID_EX_rd1,
                 rd2 => ID_EX_rd2,
                 Ext_Imm => ID_EX_extimm,
                 PC_next => ID_EX_pc,
                 zero => ALUZero,
                 ALURes => ALURes,
                 branch_address => branch_address,
                 rt => ID_EX_rt,
                 rd => ID_EX_rd,
                 wa => wa);



    process(clk)  --EX/MEM
    begin
        if rising_edge(clk) then
            if en2= '1' then
                EX_MEM_aluzero<=ALUzero;
                EX_MEM_memtoreg<=ID_EX_memtoreg;--MemtoReg;
                EX_MEM_regwrite<=ID_EX_regwrite;--RegWrite;
                EX_MEM_memwrite<=ID_EX_memwrite;--MemWrite;
                EX_MEM_branch<=ID_EX_branch;--Branch;
                EX_MEM_branchaddress<=branch_address;
                EX_MEM_alures<=ALURes;
                EX_MEM_rd2<=ID_EX_rd2;--RD2;
                EX_MEM_writeaddress<=wa;
            end if;
        end if;
    end process;


    --    MEM1: MEM
    --        port map(MemWrite => MemWrite and en2 ,
    --                 clk => clk,
    --                 en => en2,
    --                 rd2 => rd2,
    --                 ALURes => ALURes,
    --                 MemData => MemData);


    MEM1: MEM
        port map(MemWrite => MemWrite and en2 ,
                 clk => clk,
                 en => en2,
                 rd2 => EX_MEM_rd2,
                 ALURes => EX_MEM_alures,
                 MemData => MemData);



    process(clk)
    begin
        if rising_edge(clk) then
            if en2= '1' then
                MEM_WB_memtoreg<=EX_MEM_memtoreg;--MemtoReg;
                MEM_WB_regwrite<=EX_MEM_regwrite;--RegWrite;
                MEM_WB_writeaddress<=EX_MEM_writeaddress;
                MEM_WB_alures<=EX_MEM_alures;
                MEM_WB_memdata<=MemData;--MUX;
            end if;
        end if;
    end process;



    WB1: WB
        port map(ALUZero => ALUZero,
                 Branch => Branch,
                 MemtoReg => MEM_WB_memtoreg,
                 Instruction => Instruction(12 downto 0),
                 ALURes => MEM_WB_alures,
                 MemData => MEM_WB_memdata,
                 PC_next => PC_next,
                 PCSrc => PCSrc,
                 jump_address => jump_address,
                 wd => wd);

    led(15 downto 0) <= clk & RegDst & RegWrite & ALUSrc & ExtOp & ALUOp & Instruction(2 downto 0) & MemWrite & Branch & Branch & Branch & MemtoReg  & Jump;
    with sw(2 downto 0) select digits <=
        Instruction when "000",
        PC_next when "001",
        rd1 when "010",
        rd2 when "011",
        Ext_Imm when "100",
        ALURes when "101",
        MemData when "110",
        wd when "111";

end Behavioral;
