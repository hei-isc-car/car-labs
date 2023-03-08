ARCHITECTURE test OF toggler_tester IS

  constant clockFrequency : real := 66.0E6;
  constant clockPeriod     : time := 1.0/clockFrequency * 1 sec;
  signal clock_int         : std_ulogic := '1';

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
    input <= '0';
    wait for 10*clockPeriod;
                                                            -- transition 0 to 1
    input <= '1',
             '0' after  1*clockPeriod,
             '1' after  3*clockPeriod,
             '0' after  5*clockPeriod,
             '1' after  6*clockPeriod,
             '0' after  8*clockPeriod,
             '1' after 10*clockPeriod;
    wait for 50*clockPeriod;
                                                            -- transition 1 to 0
    input <= '0',
             '1' after  1*clockPeriod,
             '0' after  3*clockPeriod,
             '1' after  5*clockPeriod,
             '0' after  6*clockPeriod,
             '1' after  8*clockPeriod,
             '0' after 10*clockPeriod;
    wait for 50*clockPeriod;
                                                                -- short 1 pulse
    input <= '1',
             '0' after  1*clockPeriod,
             '1' after  3*clockPeriod,
             '0' after  5*clockPeriod,
             '1' after  6*clockPeriod,
             '0' after  8*clockPeriod;
    wait for 50*clockPeriod;
                                                      -- further toggle commands
    input <= '1', '0' after clockPeriod;
    wait for 50*clockPeriod;
    input <= '1', '0' after clockPeriod;
    wait for 50*clockPeriod;
                                                                -- short 1 pulse
                                                            -- end of simulation
    wait;
  end process;

END ARCHITECTURE test;
