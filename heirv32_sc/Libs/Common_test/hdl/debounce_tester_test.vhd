--
-- VHDL Architecture Common_test.debounce_tester.test
--
-- Created:
--          by - remy.borgeat.UNKNOWN (WE10993)
--          at - 15:30:08 12.01.2024
--
-- using Mentor Graphics HDL Designer(TM) 2019.2 (Build 5)
--
LIBRARY std;
  USE std.textio.ALL;

LIBRARY ieee;
  USE ieee.std_logic_textio.ALL;
  USE ieee.math_real.all;

LIBRARY Common_test;
  USE Common_test.testutils.all;

ARCHITECTURE test OF debounce_tester IS

  constant clockPeriod     : time := 1.0/g_clockFrequency * 1 sec;
  signal clock_int         : std_ulogic := '1';
  constant DELAY: positive := integer(ceil(((real(g_debounceTime / 1 ps) / 1.0e12) * g_clockFrequency) / real(g_minConsecutiveStateCount))) - 1;

  signal testInfo       : string(1 to 40) := (others => ' ');

BEGIN
  ------------------------------------------------------------------------------
                                                             -- reset and clock
  reset <= '1', '0' after 3*clockPeriod;
  clock_int <= not clock_int after clockPeriod/2;
  clock <= transport clock_int after clockPeriod*9/10;

  ------------------------------------------------------------------------------
                                                                 -- input signal
  process
  begin
                                                                      -- startup
    testInfo <= pad("Init", testInfo'length);
    input <= '0';
    wait until reset = '0';
    wait until clock'event and clock = '1';

    assert (debounced = not g_activeState)
      report "Startup value should be " & to_string(not g_activeState)
      severity failure;
    assert (debounced = g_activeState)
      report "Value OK"
      severity note;
    
                                                            -- transition 0 to 1
    testInfo <= pad("0 to 1", testInfo'length);
    input <= '1';
    wait for (g_minConsecutiveStateCount/2) * DELAY * clockPeriod;
    assert (debounced = not g_activeState)
      report "Value should be " & to_string(not g_activeState)
      severity failure;
    assert (debounced = g_activeState)
      report "Value OK"
      severity note;
    wait for ((g_minConsecutiveStateCount/2) + 1) * DELAY * clockPeriod;  
    assert (debounced = g_activeState)
      report "Value should be " & to_string(g_activeState)
      severity failure;
    assert (debounced = not g_activeState)
      report "Value OK"
      severity note;
    wait for 100*clockPeriod;
    
                                                            -- transition 1 to 0
    testInfo <= pad("1 to 0", testInfo'length);
    input <= '0';
    wait for (g_minConsecutiveStateCount/2) * DELAY * clockPeriod;
    assert (debounced = g_activeState)
      report "Value should be " & to_string(g_activeState)
      severity failure;
    assert (debounced = not g_activeState)
      report "Value OK"
      severity note;
    wait for ((g_minConsecutiveStateCount/2) + 1) * DELAY * clockPeriod;  
    assert (debounced = not g_activeState)
      report "Value should be " & to_string(not g_activeState)
      severity failure;
    assert (debounced = g_activeState)
      report "Value OK"
      severity note;
    wait for 100*clockPeriod;

    
                                                                -- 0 w. glitches
    testInfo <= pad("0 glitches", testInfo'length);
    input <= '0',
             '1' after  (g_minConsecutiveStateCount/4) * DELAY * clockPeriod,
             '0' after  (g_minConsecutiveStateCount/2) * DELAY * clockPeriod,
             '1' after  ((g_minConsecutiveStateCount/4)*3) * DELAY * clockPeriod,
             '0' after  (g_minConsecutiveStateCount) * DELAY * clockPeriod;
    wait for 2 * (g_minConsecutiveStateCount) * DELAY * clockPeriod;
    assert (debounced = not g_activeState)
      report "Value should be " & to_string(not g_activeState)
      severity failure;
    assert (debounced = g_activeState)
      report "Value OK"
      severity note;

    testInfo <= pad("Back to 1", testInfo'length);
    input <= '1';
    wait for g_minConsecutiveStateCount * DELAY * clockPeriod;
    assert (debounced = g_activeState)
      report "Value should be " & to_string(g_activeState)
      severity failure;
    assert (debounced = not g_activeState)
      report "Value OK"
      severity note;

                                                                -- 1 w. glitches
    testInfo <= pad("1 glitches", testInfo'length);
    input <= '1',
             '0' after  (g_minConsecutiveStateCount/4) * DELAY * clockPeriod,
             '1' after  (g_minConsecutiveStateCount/2) * DELAY * clockPeriod,
             '0' after  ((g_minConsecutiveStateCount/4)*3) * DELAY * clockPeriod,
             '1' after  (g_minConsecutiveStateCount) * DELAY * clockPeriod;
    wait for 2 * (g_minConsecutiveStateCount) * DELAY * clockPeriod;
    assert (debounced = g_activeState)
      report "Value should be " & to_string(g_activeState)
      severity failure;
    assert (debounced = not g_activeState)
      report "Value OK"
      severity note;

                                                            -- end of simulation
    testInfo <= pad("End", testInfo'length);
    wait for 10*clockPeriod;
    assert false
      report "End of simulation"
      severity failure;
    wait;
  end process;

END ARCHITECTURE test;

