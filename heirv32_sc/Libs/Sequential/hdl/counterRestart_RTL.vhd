ARCHITECTURE RTL OF counterRestart IS

  signal count: unsigned(countOut'range);

BEGIN

  countWithRestart: process(reset, clock)
  begin
    if reset = '1' then
      count <= (others => '0');
    elsif rising_edge(clock) then
      if restart = '1' then
        count <= (others => '0');
      else
        count <= count+1;
      end if;
    end if;
  end process countWithRestart;

  countOut <= count after delay;

END ARCHITECTURE RTL;
