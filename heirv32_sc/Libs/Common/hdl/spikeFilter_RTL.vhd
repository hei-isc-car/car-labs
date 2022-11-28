--------------------------------------------------------------------------------
-- Description: 
-- Filters short time spikes.
--             _   _   ____________________   _   _
-- input  ____/ \_/ \_/                    \_/ \_/ \_________________
--                         _____________________________
-- output ________________/                             \____________
--
--------------------------------------------------------------------------------

ARCHITECTURE rtl OF spikeFilter IS
 
  signal filterCounter : unsigned(counterBitNb-1 downto 0);
  signal inputSynch, inputDelayed, inputChanged : std_ulogic;
 
BEGIN
  ------------------------------------------------------------------------------
                                                   -- Synchronize input to clock
  synchInput: process(reset, clock)
  begin
    if reset = '1' then
      inputSynch <= '0';
    elsif rising_edge(clock) then
      inputSynch <= input xor invertInput;
    end if;
  end process synchInput;

  ------------------------------------------------------------------------------
                                                           -- Find edge on input
  delayInput: process(reset, clock)
  begin
    if reset = '1' then
      inputDelayed <= '0';
    elsif rising_edge(clock) then
      inputDelayed <= inputSynch;
    end if;
  end process delayInput;

  inputChanged <= '1' when inputDelayed /= inputSynch
    else '0';

  ------------------------------------------------------------------------------
                                                             -- Debounce counter
  countDeadTime: process(reset, clock)
  begin
    if reset = '1' then
      filterCounter <= (others => '0');
    elsif rising_edge(clock) then
      if filterCounter = 0 then
        if inputChanged = '1' then
          filterCounter <= filterCounter + 1;
        end if;
      elsif signed(filterCounter)+1 = 0 then
        if inputChanged = '1' then
          filterCounter <= filterCounter - 1;
        end if;
      else
        if inputSynch = '0' then
          filterCounter <= filterCounter - 1;
        else
          filterCounter <= filterCounter + 1;
        end if;
      end if;
    end if;
  end process countDeadTime;

  ------------------------------------------------------------------------------
                                                                -- Update output
  updateOutput: process(reset, clock)
  begin
    if reset = '1' then
      filtered <= '0';
    elsif rising_edge(clock) then
      if filterCounter = 0 then
        filtered <= '0';
      elsif signed(filterCounter)+1 = 0 then
        filtered <= '1';
      end if;
    end if;
  end process updateOutput;
 
END ARCHITECTURE rtl;
