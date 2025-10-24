ARCHITECTURE sim OF clockGenerator IS

  constant clockPeriod: time := (1.0/clockFrequency) * 1 sec;
  signal clock_int: std_uLogic := '1';

BEGIN

  reset <= '1', '0' after 2*clockPeriod;

  clock_int <= not clock_int after clockPeriod/2;
  clock <= transport clock_int after clockPeriod*9.0/10.0;

END ARCHITECTURE sim;
