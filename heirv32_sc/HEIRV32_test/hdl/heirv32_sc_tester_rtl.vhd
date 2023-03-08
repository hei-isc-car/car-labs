LIBRARY std;
  USE std.textio.ALL;

LIBRARY ieee;
  USE ieee.std_logic_textio.ALL;

LIBRARY Common_test;
  USE Common_test.testutils.all;

ARCHITECTURE rtl OF heirv32_sc_tester IS

  constant clockPeriod  : time := 1.0/66E6 * 1 sec;
  signal sClock         : std_uLogic := '1';
  signal sReset         : std_uLogic ;

  signal testInfo       : string(1 to 40) := (others => ' ');

BEGIN

 ------------------------------------------------------------------------------
                                                              -- reset and clock
  sReset <= '1', '0' after 3.5*clockPeriod;
  rst <= sReset;

  sClock <= not sClock after clockPeriod/2;
  clk <= transport sClock after 0.9*clockPeriod;

  btns <= (others => '0');

  process
    -- Wait list
    -- 1 for all
  begin
    en <= '0';

    testInfo <= pad("Wait reset", testInfo'length);
    wait until rst = '0';

    while true loop
      en <= '1';

      testInfo <= pad("Addi, addr. 00", testInfo'length);
      wait until clk'event and clk = '1';
      wait for clockPeriod;

      testInfo <= pad("Addi, addr. 04", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Addi, addr. 08", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Or, addr. 0C", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("And, addr. 10", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Add, addr. 14", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Beq, addr. 18", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Slt, addr. 1C", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Beq, addr. 20", testInfo'length);
      wait for clockPeriod;

      --testInfo <= pad("Addi, addr. 24", testInfo'length);
      --wait for clockPeriod;

      testInfo <= pad("Slt, addr. 28", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Add, addr. 2C", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Sub, addr. 30", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Sw, addr. 34", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Lw, addr. 38", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Add, addr. 3C", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Jal, addr. 40", testInfo'length);
      wait for clockPeriod;

      --testInfo <= pad("Addi, addr. 44", testInfo'length);
      --wait for clockPeriod;

      testInfo <= pad("Add, addr. 48", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Sw, addr.4C", testInfo'length);
      wait for clockPeriod;

      testInfo <= pad("Beq, addr. 50", testInfo'length);
      wait for 0.8*clockPeriod;

      en <= '0';
      testInfo <= pad("Wait a bit, PC should be 0", testInfo'length);
      wait for 9.2*clockPeriod;
      testInfo <= pad("Enabling system", testInfo'length);
      en <= '1';
      wait until clk'event and clk = '1';

    end loop;
  end process;

END ARCHITECTURE rtl;
