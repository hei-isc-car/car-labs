--------------------------------------------------------------------------------
-- Copyright 2013 HES-SO Valais Wallis (www.hevs.ch)
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
-- Counter
--   Simple counter with a generic width of nbBits.
--
--   Created on 2013-08-10
--
--   Version: 1.0
--   Author: Oliver A. Gubler (oliver.gubler@hevs.ch)
--------------------------------------------------------------------------------
--
ARCHITECTURE rtl OF counterEnableResetSync IS
  
  signal sCountOut: unsigned(countOut'range);

BEGIN

  countEndlessly: process(reset, clock)
  begin
    if reset = '1' then
      sCountOut <= (others => '0');
    elsif rising_edge(clock) then
      if resetSync = '1' then
        sCountOut <= (others => '0');
      elsif enable = '1' then
        sCountOut <= sCountOut + 1;
      end if;
    end if;
  end process countEndlessly;

  countOut <= sCountOut after delay;

END ARCHITECTURE RTL;
