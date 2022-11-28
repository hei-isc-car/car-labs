ARCHITECTURE sim OF TFF_pre IS

  signal q_int: std_ulogic;

BEGIN

  process(clk, pre)
  begin
    if pre = '1' then
      q_int <= '1' after delay;
    elsif rising_edge(clk) then
      q_int <= t xor q_int after delay;
    end if;
  end process;

  q <= q_int;

END sim;
