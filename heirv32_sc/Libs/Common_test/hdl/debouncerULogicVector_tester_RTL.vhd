ARCHITECTURE RTL OF debouncerULogicVector_tester IS

  constant clockFrequency : real := 100.0E6;
  constant clockPeriod     : time := 1.0/clockFrequency * 1 sec;
  signal clock_int         : std_ulogic := '1';

  constant longDelay : time := 2**(counterBitNb+1) * clockPeriod;

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
    input <= (others => '0');
    wait for longDelay;
                                                            -- transition 0 to 1
    input(1) <= '1',
                '0' after  1*clockPeriod,
                '1' after  3*clockPeriod,
                '0' after  5*clockPeriod,
                '1' after  6*clockPeriod,
                '0' after  8*clockPeriod,
                '1' after 10*clockPeriod;
    wait for longDelay;
                                                      -- transition to other bit
                                                            -- transition 1 to 0
    input(1) <= '0';
    wait for longDelay;
    input(2) <= '1';
    wait for longDelay;
                                                            -- transition 1 to 0
    input(2) <= '0',
                '1' after  1*clockPeriod,
                '0' after  3*clockPeriod,
                '1' after  5*clockPeriod,
                '0' after  6*clockPeriod,
                '1' after  8*clockPeriod,
                '0' after 10*clockPeriod;
    wait for longDelay;
                                                                -- short 1 pulse
    input(3) <= '1',
                '0' after  1*clockPeriod,
                '1' after  3*clockPeriod,
                '0' after  5*clockPeriod,
                '1' after  6*clockPeriod,
                '0' after  8*clockPeriod;
                                                            -- end of simulation
    wait;
  end process;

END ARCHITECTURE RTL;
