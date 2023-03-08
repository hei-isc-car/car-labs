-- filename:          toggler.vhd
-- kind:              vhdl file
-- first created:     05.03.2012
-- created by:        zas
--------------------------------------------------------------------------------
-- History:
-- v0.1 : cof 22.01.2013 -- Initial version
--------------------------------------------------------------------------------
-- Description: 
-- Debounces a button on both edges.
--             _                            _
-- input  ____/ \__________________________/ \____________
--              _____________________________
-- output _____/                             \____________
--
-- If the generic "counterBitNb" is greater than zero, a debouncer is placed on
-- the input signal.
--
--------------------------------------------------------------------------------

ARCHITECTURE rtl OF toggler IS
 
  signal inputDebounced : std_ulogic;
  signal inputDelayed, inputChangedTo1 : std_ulogic;
  signal toggle_int : std_ulogic;

  COMPONENT debouncer
  GENERIC (
    counterBitNb : positive := 18;
    invertInput : std_ulogic := '0'
  );
  PORT (
    reset     : IN     std_ulogic ;
    clock     : IN     std_ulogic ;
    input     : IN     std_ulogic ;
    debounced : OUT    std_ulogic 
  );
  END COMPONENT;

BEGIN
  ------------------------------------------------------------------------------
                                                               -- Debounce input
  useInputDirectly: if counterBitNb = 0 generate
    inputDebounced <= input;
  end generate useInputDirectly;

  debounceInput: if counterBitNb > 0 generate
    I_debouncer : debouncer
      GENERIC MAP (
        counterBitNb => counterBitNb,
        invertInput => invertInput
      )
      PORT MAP (
        reset     => reset,
        clock     => clock,
        input     => input,
        debounced => inputDebounced
      );
  end generate debounceInput;

  ------------------------------------------------------------------------------
                                                           -- Find edge on input
  delayInput: process(reset, clock)
  begin
    if reset = '1' then
      inputDelayed <= '0';
    elsif rising_edge(clock) then
      inputDelayed <= inputDebounced;
    end if;
  end process delayInput;

  inputChangedTo1 <= '1' when (inputDebounced = '1') and (inputDelayed = '0')
    else '0';

  ------------------------------------------------------------------------------
                                                                -- Toggle output
  toggleOutput: process(reset, clock)
  begin
    if reset = '1' then
      toggle_int <= '0';
    elsif rising_edge(clock) then
      if inputChangedTo1 = '1' then
        toggle_int <= not toggle_int;
      end if;
    end if;
  end process toggleOutput;
 
   toggle <= toggle_int;
 
END ARCHITECTURE rtl;
