ARCHITECTURE rtl OF rotaryToUnsigned IS

  signal rotaryDelayed1, rotaryDelayed2, rotaryStable : unsigned(rotary'range);
  signal rotary_changed : std_ulogic;
  signal glitchDelayCounter : unsigned(counterBitNb-1 downto 0);
  signal rotaryStableDelayed : unsigned(rotary'range);
  signal numberMsbs : unsigned(number'length-rotary'length-1 downto 0);

BEGIN
  ------------------------------------------------------------------------------
                                         -- synchronize input and detect changes
  delayRotary: process(reset, clock)
  begin
    if reset = '1' then
      rotaryDelayed1 <= (others => '0');
      rotaryDelayed2 <= (others => '0');
    elsif rising_edge(clock) then
      rotaryDelayed1 <= rotary;
      rotaryDelayed2 <= rotaryDelayed1;
    end if;
  end process delayRotary;

  rotary_changed <= '1' when rotaryDelayed1 /= rotaryDelayed2
    else '0';
                                                              -- count dead time
  countDeadTime: process(reset, clock)
  begin
    if reset = '1' then
      glitchDelayCounter <= (others => '1');
    elsif rising_edge(clock) then
      if rotary_changed = '1' then
        glitchDelayCounter <= (others => '1');
      elsif glitchDelayCounter > 0 then
        glitchDelayCounter <= glitchDelayCounter - 1;
      end if;
    end if;
  end process countDeadTime;
                                                -- store new rotary button value
  storeRotary: process(reset, clock)
  begin
    if reset = '1' then
      rotaryStable <= (others => '0');
    elsif rising_edge(clock) then
      if glitchDelayCounter = 0 then
        rotaryStable <= rotaryDelayed2;
      end if;
    end if;
  end process storeRotary;

  ------------------------------------------------------------------------------
                                     -- keep previous value of stablilzed rotary
  delayRotaryStable: process(reset, clock)
  begin
    if reset = '1' then
      rotaryStableDelayed <= (others => '0');
    elsif rising_edge(clock) then
      rotaryStableDelayed <= rotaryStable;
    end if;
  end process delayRotaryStable;
                                         -- synchronize input and detect changes
  updateMsbs: process(reset, clock)
  begin
    if reset = '1' then
      numberMsbs <= (others => '0');
    elsif rising_edge(clock) then
      if (rotaryStable = 0) and (rotaryStableDelayed+1 = 0) then
        numberMsbs <= numberMsbs + 1;
      elsif (rotaryStable+1 = 0) and (rotaryStableDelayed = 0) then
        numberMsbs <= numberMsbs - 1;
      end if;
    end if;
  end process updateMsbs;

  number <= numberMsbs & rotaryStableDelayed;

END ARCHITECTURE rtl;
