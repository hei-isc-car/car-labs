ARCHITECTURE sim OF DFF_pre IS
BEGIN

  process(clk, pre)
  begin
    if pre = '1' then
      q <= '1' after delay;
    elsif rising_edge(clk) then
      q <= d after delay;
    end if;
  end process;

END sim;
