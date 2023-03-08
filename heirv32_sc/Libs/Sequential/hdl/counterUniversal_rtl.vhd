ARCHITECTURE rtl OF counterUniversal IS

  -- Internal counter
  signal lvec_count: unsigned(countOut'range);
  -- If value reached
    -- down_nUp = 1 => pulse @ loadValue-1
    -- down_nUp = 0 => pulse @ max + 1
  signal lsig_reached : std_ulogic;

BEGIN

  countUniversal: process(reset, clock)
  begin
    -- Set counter to loadValue
    if reset = '1' then
      lvec_count <= loadValue;
    elsif rising_edge(clock) then
      lsig_reached <= '0';
      -- Load has priority
      if load = '1' then
        lvec_count <= loadValue;
      -- Else if we are enabled, count
      elsif enable = '1' then
        -- Counting up
        if down_nUp = '0' then
          -- Reset to loadValue
          if lvec_count + 1 = 0 then
            lvec_count <= loadValue;
            lsig_reached <= '1';
          else
            lvec_count <= lvec_count + 1;
          end if;
        -- Counting down
        else
          -- Reset to max value
          if lvec_count = loadValue then
            lvec_count <= (others=>'1');
            lsig_reached <= '1';
          else
            lvec_count <= lvec_count - 1;
          end if;
        end if;
      end if;
    end if;
  end process countUniversal;

  -- Output count with gate delay in simu
  countOut <= lvec_count after g_delay;
  -- Output reached with gate delay in simu
  targetReached <= lsig_reached after g_delay;

END ARCHITECTURE rtl;