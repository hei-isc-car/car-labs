ARCHITECTURE RTL OF sdramControllerRefreshCounter IS

  signal delayCounter: unsigned(delayCounterBitNb-1 downto 0);
  signal endOfDelay: std_ulogic;

BEGIN

  countDelay : process(reset, clock)
  begin
    if reset = '1' then
      delayCounter <= (others => '0');
    elsif rising_edge(clock) then
      if endOfDelay = '1' then
        delayCounter <= to_unsigned(1, delayCounter'length);
      else
        delayCounter <= delayCounter + 1;
      end if;
    end if;
  end process countDelay;

  findEndOfDelay: process(powerUpDone, delayCounter)
  begin
    endOfDelay <= '0';
    if powerUpDone = '0' then
      if delayCounter+1 = 0 then
        endOfDelay <= '1';
      end if;
    else
      if delayCounter+1 >= refreshPeriodNb then
        endOfDelay <= '1';
      end if;
    end if;
  end process findEndOfDelay;

  endOfRefreshCount <= endOfDelay;

  signalRefresh: process(powerUpDone, delayCounter)
  begin
    selectRefresh <= '0';
    if (powerUpDone = '1') and (delayCounter < 1024) then
      if (delayCounter <= 16) or (delayCounter(3 downto 0) = 0) then
        selectRefresh <= '1';
      end if;
    end if;
  end process signalRefresh;


END ARCHITECTURE RTL;
