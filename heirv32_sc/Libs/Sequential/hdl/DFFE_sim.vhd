ARCHITECTURE sim OF DFFE IS
BEGIN

  process(clk, clr)
  begin
    if clr = '1' then
      q <= '0' after delay;
    elsif rising_edge(clk) then
      if e = '1' then
        q <= d after delay;
      end if;
    end if;
  end process;

END ARCHITECTURE sim;

