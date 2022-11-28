ARCHITECTURE sim OF DFF IS
BEGIN

  process(clk, clr)
  begin
    if clr = '1' then
      q <= '0' after delay;
    elsif rising_edge(clk) then
      q <= d after delay;
    end if;
  end process;

END sim;
