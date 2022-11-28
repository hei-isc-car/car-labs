-- filename:          debouncer.vhd
-- kind:              vhdl file
-- first created:     05.03.2012
-- created by:        zas
--------------------------------------------------------------------------------
-- History:
-- v0.1 : zas 05.03.2012 -- Initial Version
-- v0.2 : cof 22.01.2013 -- synchronization to clock
--------------------------------------------------------------------------------
-- Description: 
-- Debounces a button on both edges.
--             _   _   ____________________   _   _
-- input  ____/ \_/ \_/                    \_/ \_/ \______
--              _____________________________
-- output _____/                             \____________
--
--------------------------------------------------------------------------------

ARCHITECTURE rtl OF debouncerULogicVector IS
 
  signal inputNormal : std_ulogic_vector(input'range);
  signal inputSynch, inputDelayed, inputChanged : std_ulogic;
  signal debounceCounter : unsigned(counterBitNb-1 downto 0);
 
BEGIN
  ------------------------------------------------------------------------------
                                                               -- adapt polarity
  adaptPolarity: process(input)
  begin
    for index in input'range loop
      inputNormal(index) <= input(index) xor invertInput;
    end loop;
  end process adaptPolarity;

  ------------------------------------------------------------------------------
                                                   -- Synchronize input to clock
  synchInput: process(reset, clock)
    variable inputOr : std_ulogic;
  begin
    if reset = '1' then
      inputSynch <= '0';
    elsif rising_edge(clock) then
      inputOr := '0';
      for index in input'range loop
        inputOr := inputOr or inputNormal(index);
      end loop;
      inputSynch <= inputOr;
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
      debounceCounter <= (others => '0');
    elsif rising_edge(clock) then
      if debounceCounter = 0 then
        if inputChanged = '1' then
          debounceCounter <= debounceCounter - 1;
        end if;
      else
        debounceCounter <= debounceCounter - 1;
      end if;
    end if;
  end process countDeadTime;

  ------------------------------------------------------------------------------
                                                                -- Update output
  updateOutput: process(reset, clock)
  begin
    if reset = '1' then
      debounced <= (others => '0');
    elsif rising_edge(clock) then
      if (inputChanged = '1') and (debounceCounter = 0) then
        debounced <= inputNormal;
      elsif debounceCounter = 1 then
        debounced <= inputNormal;
      end if;
    end if;
  end process updateOutput;
 
END ARCHITECTURE rtl;
