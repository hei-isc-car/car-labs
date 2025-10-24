-- filename:          blinker.vhd
-- kind:              vhdl file
-- first created:     18.06.2012
-- created by:        zas
--------------------------------------------------------------------------------
-- History:
-- v0.1 : zas 18.06.2012 -- Initial Version
--------------------------------------------------------------------------------
-- Description:
-- For let blinking a LED with an signal event
-- Mode = 0 (reactive on rising edge)
--             ___________________________________________
-- input  ____/
--             ___________________
-- output ____/                   \_______________________
-- time   0s                    0.5s                    1s
--
--             _
-- input  ____/ \_________________________________________
--             ___________________
-- output ____/                   \_______________________
-- time   0s                    0.5s                    1s
----
-- Mode = 1 (reactive on falling edge)
--        _____
-- input       \__________________________________________
--               ___________________
-- output ______/                   \_____________________
-- time   0s                    0.5s                    1s
--
--             _
-- input  ____/ \_________________________________________
--                ___________________
-- output ______ /                   \____________________
-- time   0s                    0.5s                    1s
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;

LIBRARY Common;
USE Common.CommonLib.all;


ARCHITECTURE arch OF blinker IS

  constant c : integer := clockFrequency/2; -- 500ms blink

  signal cnt       : unsigned(requiredBitNb(c)-1 downto 0);
  signal en_delay  : std_ulogic;
  signal blink_int : std_ulogic;

BEGIN

  process(reset, clock)
  begin
    if reset = '1' then
      en_delay  <= '0';
      blink_int <= '0';
      cnt       <= (others => '0');
    elsif rising_edge(clock) then
      en_delay <= en;
      -- detect rising_edge
      if mode = 0 then
        if blink_int = '0' and en_delay = '0' and en = '1' then
          blink_int <= '1';
        end if;
      else
      -- detect falling edge
        if blink_int = '0' and en_delay = '1' and en = '0' then
          blink_int <= '1';
        end if;
      end if;
      -- blink
      if blink_int = '1' then
        if (cnt < c) then
          cnt <= cnt + 1;
        else
          cnt       <= (others => '0');
          blink_int <= '0';
        end if;
      end if;
    end if;
  end process;

  -- Set output
  blink <= blink_int;
END ARCHITECTURE arch;
