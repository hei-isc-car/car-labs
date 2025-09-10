ARCHITECTURE RTL OF sdramControllerTimingsShiftRegister IS

  --constant leadingZeroesNb: positive := 2;
  --constant leadingZeroes: std_ulogic_vector(1 to leadingZeroesNb) := (others => '0');
  --signal shiftReg: std_ulogic_vector(1 to timerDone'high-leadingZeroesNb);
  signal shiftReg: std_ulogic_vector(1 to timerDone'high);

BEGIN

  shiftToken : process(reset, clock)
  begin
    if reset = '1' then
      shiftReg <= (others => '0');
    elsif rising_edge(clock) then
      shiftReg(1) <= timerStart;
      shiftReg(2 to shiftReg'right) <= shiftReg(1 to shiftReg'right-1);
    end if;
  end process shiftToken;

  --timerDone <= leadingZeroes & shiftReg;
  timerDone <= shiftReg;

END ARCHITECTURE RTL;

