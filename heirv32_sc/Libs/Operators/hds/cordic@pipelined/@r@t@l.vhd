ARCHITECTURE RTL OF tickLengthCounter IS
  signal counter: unsigned(2 downto 0);
  signal enCounter: std_ulogic;
BEGIN

  enCounter <= tickStep and enStep;

  count: process(reset, clock)
  begin
    if reset = '1' then
      counter <= (others => '0');
    elsif rising_edge(clock) then
      if restart = '1' then
        counter <= (others => '1');
      elsif enCounter = '1' then
        if counter < 6 then
          counter <= counter + 1;
        else
          counter <= (others => '0');
        end if;
      end if;
    end if;
  end process count;

  buildDone: process(counter, enStep)
  begin
    if (
          ( counter = 1) or
          ( counter = 4) or
          ( counter = 6)
       ) then
      tickDone <= enStep;
    else
      tickDone <= '0';
    end if;
  end process buildDone;

END RTL;
