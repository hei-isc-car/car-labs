ARCHITECTURE RTL OF sdramControllerSR IS
BEGIN

  setReset: process(reset, clock)
  begin
    if reset = '1' then
      flag <= '0';
    elsif rising_edge(clock) then
      if setFlag = '1' then
        flag <= '1';
      elsif resetFlag = '1' then
        flag <= '0';
      end if;
    end if;
  end process setReset;

END ARCHITECTURE RTL;

