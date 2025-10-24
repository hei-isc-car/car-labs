ARCHITECTURE test OF rotaryToUnsigned_tester IS

  constant clockFrequency : real := 100.0E6;
  constant clockPeriod    : time := 1.0/clockFrequency * 1 sec;
  signal clock_int        : std_ulogic := '1';

  constant stepPeriod     : time := 100*clockPeriod;
  signal rotary_int       : unsigned(rotary'range);

BEGIN
  ------------------------------------------------------------------------------
                                                             -- reset and clock
  reset <= '1', '0' after 3*clockPeriod;
  clock_int <= not clock_int after clockPeriod/2;
  clock <= transport clock_int after clockPeriod*9/10;

  ------------------------------------------------------------------------------
                                                                 -- input signal
  turnRotary: process
  begin
    rotary_int <= (others => '0');
    wait for 10*stepPeriod;
                                                          -- count over max value
    for index in 1 to 2**outputBitNb+2 loop
      rotary_int <= rotary_int + 1;
      wait for stepPeriod;
    end loop;
                                                              -- count down again
    for index in 1 to 2**outputBitNb+2 loop
      rotary_int <= rotary_int - 1;
      wait for stepPeriod;
    end loop;
                                                             -- end of simulation
    wait;
  end process turnRotary;

  addGlitches: process
  begin
    wait on rotary_int;
    rotary <= (others => '0');
    wait for clockPeriod;
    rotary <= (others => '1');
    wait for clockPeriod;
    rotary <= rotary_int;
  end process addGlitches;

END ARCHITECTURE test;
