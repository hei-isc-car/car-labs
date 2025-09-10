LIBRARY std;
  USE std.textio.ALL;

LIBRARY ieee;
  USE ieee.std_logic_textio.ALL;

LIBRARY Common_test;
  USE Common_test.testutils.all;

ARCHITECTURE test_EBS2 OF heirv32_sc_tester IS

  constant clockPeriod  : time := 1.0/66E6 * 1 sec;
  signal sClock         : std_uLogic := '1';
  signal sReset         : std_uLogic ;

  signal testInfo       : string(1 to 40) := (others => ' ');
  
  signal PC_u           : unsigned(31 downto 0);
  signal instruction, PC : std_ulogic_vector(31 downto 0);
  signal regwrite, ALUSrc, memWrite, PCSrc : std_ulogic;
  signal immSrc, resultSrc : std_ulogic_vector(1 downto 0);
  signal ALUControl     : std_ulogic_vector(2 downto 0);
  
  procedure checkProc(
    msg :           string;
    PCArg :         unsigned(31 downto 0);
    regwriteArg :   std_ulogic;
    immSrcArg :     std_ulogic_vector(1 downto 0);
    ALUSrcArg :     std_ulogic;
    memWriteArg :   std_ulogic;
    resultSrcArg :  std_ulogic_vector(1 downto 0);
    ALUControlArg : std_ulogic_vector(2 downto 0);
    PCSrcArg :      std_ulogic) is
  begin
    wait for 0.8*clockPeriod;
    std.textio.write(std.textio.output, LF & "===================" & LF);
    std.textio.write(std.textio.output, "Testing " & msg  & LF);
    assert (PC_u = PCArg)
      report ("PC error - expected " & to_hstring(PC_u)) severity error;
    assert (regwrite = regwriteArg)
      report ("regwrite error - expected " & to_string(regwriteArg)) severity error;
    assert (immSrc = immSrcArg)
      report ("immSrc error - expected " & to_string(immSrcArg)) severity error;
    assert (ALUSrc = ALUSrcArg)
      report ("ALUSrc error - expected " & to_string(ALUSrcArg)) severity error;
    assert (memWrite = memWriteArg)
      report ("memWrite error - expected " & to_string(memWriteArg)) severity error;
    assert (resultSrc = resultSrcArg)
      report ("resultSrc error - expected " & to_string(resultSrcArg)) severity error;
    assert (ALUControl = ALUControlArg)
      report ("ALUControl error - expected " & to_string(ALUControlArg)) severity error;
    assert (PCSrc = PCSrcArg)
      report ("PCSrc error - expected " & to_string(PCSrcArg)) severity error;
    if (regwrite = regwriteArg) AND (immSrc = immSrcArg) AND (ALUSrc = ALUSrcArg) AND (memWrite = memWriteArg) AND
      (resultSrc = resultSrcArg) and (ALUControl = ALUControlArg) AND (PCSrc = PCSrcArg) then
      report " ** Ok" severity note;
    end if;
    std.textio.write(std.textio.output, "===================" & LF);
    
    wait until clk'event and clk = '1';
  end procedure checkProc;

BEGIN

 ------------------------------------------------------------------------------
                                                              -- reset and clock
  rst <= sReset;

  sClock <= not sClock after clockPeriod/2;
  clk <= transport sClock after 0.9*clockPeriod;

  btns <= (others => '0');

 ------------------------------------------------------------------------------
                                                              -- test signals
                                
  (PC, instruction, regwrite, immSrc, ALUSrc, memWrite, resultSrc, ALUControl, PCSrc) <= test;
  PC_u <= unsigned(PC);

  process
  begin
    en <= '0';
    sReset <= '1';
    testInfo <= pad("Wait reset done", testInfo'length);
    wait for 3.5*clockPeriod;
    wait until clk'event and clk = '1';
    wait for 0.1*clockPeriod;
    sReset <= '0';

    while true loop
      en <= '1';

      testInfo <= pad("Addi, addr. 0x00", testInfo'length);
      checkProc("Addi, addr. 0x00", x"00000000", '1', "00", '1', '0', "00", "000", '0');

      testInfo <= pad("Addi, addr. 0x04", testInfo'length);
      checkProc("Addi, addr. 0x04", x"00000004", '1', "00", '1', '0', "00", "000", '0');

      testInfo <= pad("Addi, addr. 0x08", testInfo'length);
      checkProc("Addi, addr. 0x08", x"00000008", '1', "00", '1', '0', "00", "000", '0');

      testInfo <= pad("Or, addr. 0x0C", testInfo'length);
      checkProc("Or, addr. 0x0C", x"0000000C", '1', "--", '0', '0', "00", "011", '0');

      testInfo <= pad("And, addr. 0x10", testInfo'length);
      checkProc("And, addr. 0x10", x"00000010", '1', "--", '0', '0', "00", "010", '0');

      testInfo <= pad("Add, addr. 0x14", testInfo'length);
      checkProc("Add, addr. 0x14", x"00000014", '1', "--", '0', '0', "00", "000", '0');

      testInfo <= pad("Beq, addr. 0x18", testInfo'length);
      checkProc("Beq, addr. 0x18", x"00000018", '0', "10", '0', '0', "00", "001", '0');

      testInfo <= pad("Slt, addr. 0x1C", testInfo'length);
      checkProc("Slt, addr. 0x1C", x"0000001C", '1', "--", '0', '0', "00", "101", '0');

      testInfo <= pad("Beq, addr. 0x20", testInfo'length);
      checkProc("Beq, addr. 0x20", x"00000020", '0', "10", '0', '0', "00", "001", '1');

      --testInfo <= pad("Addi, addr. 0x24", testInfo'length);

      testInfo <= pad("Slt, addr. 0x28", testInfo'length);
      checkProc("Slt, addr. 0x28", x"00000028", '1', "--", '0', '0', "00", "101", '0');

      testInfo <= pad("Add, addr. 0x2C", testInfo'length);
      checkProc("Add, addr. 0x2C", x"0000002C", '1', "--", '0', '0', "00", "000", '0');

      testInfo <= pad("Sub, addr. 0x30", testInfo'length);
      checkProc("Sub, addr. 0x30", x"00000030", '1', "--", '0', '0', "00", "001", '0');

      testInfo <= pad("Sw, addr. 0x34", testInfo'length);
      checkProc("Sw, addr. 0x34", x"00000034", '0', "01", '1', '1', "00", "000", '0');

      testInfo <= pad("Lw, addr. 0x38", testInfo'length);
      checkProc("Lw, addr. 0x38", x"00000038", '1', "00", '1', '0', "01", "000", '0');

      testInfo <= pad("Add, addr. 0x3C", testInfo'length);
      checkProc("Add, addr. 0x3X", x"0000003C", '1', "--", '0', '0', "00", "000", '0');

      testInfo <= pad("Jal, addr. 0x40", testInfo'length);
      checkProc("Jal, addr. 0x40", x"00000040", '1', "11", '0', '0', "10", "000", '1');

      --testInfo <= pad("Addi, addr. 0x44", testInfo'length);

      testInfo <= pad("Add, addr. 0x48", testInfo'length);
      checkProc("Add, addr. 0x48", x"00000048", '1', "--", '0', '0', "00", "000", '0');

      testInfo <= pad("Sw, addr. 0x4C", testInfo'length);
      checkProc("Sw, addr. 0x4C", x"0000004C", '0', "01", '1', '1', "00", "000", '0');

      testInfo <= pad("Beq, addr. 0x50", testInfo'length);
      checkProc("Beq, addr. 0x50", x"00000050", '0', "10", '0', '0', "00", "001", '1');

      en <= '0';
      testInfo <= pad("Wait a bit, PC should be 0", testInfo'length);
      checkProc("Prog. loop", x"00000000", '1', "00", '1', '0', "00", "000", '0');
      wait for 9.2*clockPeriod;
      wait until clk'event and clk = '1';
      wait for 0.1*clockPeriod;
      
    end loop;
  end process;

END ARCHITECTURE test_EBS2;
