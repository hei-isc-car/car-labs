ARCHITECTURE RTL OF counter IS

  signal count: unsigned(countOut'range);

BEGIN

  countEndlessly: process(reset, clock)
  begin
    if reset = '1' then
      count <= (others => '0');
    elsif rising_edge(clock) then
      count <= count+1;
    end if;
  end process countEndlessly;

  countOut <= count after delay;

END ARCHITECTURE RTL;
