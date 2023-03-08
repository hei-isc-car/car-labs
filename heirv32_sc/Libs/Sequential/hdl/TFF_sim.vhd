ARCHITECTURE sim OF TFF IS

  signal q_int: std_ulogic;

BEGIN

  process(clk, clr)
  begin
    if clr = '1' then
      q_int <= '0' after delay;
    elsif rising_edge(clk) then
      q_int <= t xor q_int after delay;
    end if;
  end process;

  q <= q_int;

END sim;
