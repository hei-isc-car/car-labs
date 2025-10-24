ARCHITECTURE test OF spikeFilter_tester IS

  constant clockFrequency : real := 100.0E6;
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
                                                          -- loop on pulse width
    for pulseWidth in 1 to 10 loop
                                                   -- send positive pulses train
      for index in 1 to 8 loop
        input <= '1';
        wait for pulseWidth * clockPeriod;
        input <= '0';
        wait for pulseWidth * clockPeriod;
      end loop;
                                                               -- set input high
      input <= '1';
      wait for 100*clockPeriod;
                                                   -- send negative pulses train
      for index in 1 to 8 loop
        input <= '0';
        wait for pulseWidth * clockPeriod;
        input <= '1';
        wait for pulseWidth * clockPeriod;
      end loop;
                                                                -- set input low
      input <= '0';
      wait for 100*clockPeriod;
    end loop;
                                                            -- end of simulation
    wait;
  end process;

END ARCHITECTURE test;
