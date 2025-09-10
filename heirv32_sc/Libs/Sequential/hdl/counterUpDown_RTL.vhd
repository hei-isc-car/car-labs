ARCHITECTURE RTL OF counterUpDown IS

  signal sCountOut: unsigned(countOut'range);

BEGIN

  count: process(reset, clock)
  begin
    if reset = '1' then
      sCountOut <= (others => '0');
    elsif rising_edge(clock) then
      if up = '1' then
        sCountOut <= sCountOut + 1;
      elsif down = '1' then
        sCountOut <= sCountOut - 1;
      end if;
    end if;
  end process count;

  countOut <= sCountOut after delay;

END ARCHITECTURE RTL;
