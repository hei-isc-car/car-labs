ARCHITECTURE sim OF DFFE_pre IS
BEGIN

  process(clk, pre)
  begin
    if pre = '1' then
      q <= '1' after delay;
    elsif rising_edge(clk) then
      if e = '1' then
        q <= d after delay;
      end if;
    end if;
  end process;

END ARCHITECTURE sim;

