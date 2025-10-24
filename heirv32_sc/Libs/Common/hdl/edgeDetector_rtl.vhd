--------------------------------------------------------------------------------
-- Copyright 2014 HES-SO Valais Wallis (www.hevs.ch)
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3 of the License, or
-- (at your option) any later version.
--
-- This program IS distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.
-- You should have received a copy of the GNU General Public License along with
-- this program. If not, see <http://www.gnu.org/licenses/>
--------------------------------------------------------------------------------
-- EdgeDetector
--   Detect rising and falling edges of a signal.
--
--------------------------------------------------------------------------------
-- History:
-- v0.1 : guo 2014-04-02 -- Initial version
-- v1.0 : cof 2019-10-02 -- Updated symbol
--------------------------------------------------------------------------------
ARCHITECTURE RTL OF edgeDetector IS
  
  SIGNAL pulse_delayed : std_ulogic;
  SIGNAL rising_detected_s : std_ulogic;
  SIGNAL falling_detected_s : std_ulogic;

BEGIN

  -- delay pulse
  reg : PROCESS (reset, clock)
  BEGIN
    IF reset = '1' THEN
      pulse_delayed <= '0';
    ELSIF rising_edge(clock) THEN
      pulse_delayed <= pulse;  
    END IF;    
  END PROCESS reg ;
  
  -- edge detection
  rising <= '1' when (pulse = '1') and (pulse_delayed = '0')
    else '0'; 
  falling <= '1' when (pulse = '0') and (pulse_delayed = '1')
    else '0'; 
  
END ARCHITECTURE RTL;
