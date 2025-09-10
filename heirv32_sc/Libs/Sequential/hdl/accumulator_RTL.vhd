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
-- Accumulator
--   Accumulator with the step as signal and a synchronous clear signal.
--
--   Created on 2013-03-03
--
--   Version: 1.0
--   Author: Oliver A. Gubler (oliver.gubler@hevs.ch)
--------------------------------------------------------------------------------
--
ARCHITECTURE RTL OF accumulator IS
  signal sum_s : unsigned(bitNb-1 downto 0);
begin
  
  process (clock, reset)
	begin
	  if reset = '1' then
	    sum_s <= (OTHERS => '0');
    elsif rising_edge(clock)	then
      if enable = '1' then
    	   sum_s <= unsigned(step) + sum_s;
      end if;
      if clear = '1' then
    	   sum_s <= (OTHERS => '0');
  	   end if;
  	 end if;
	end process;

  acc <= sum_s;

END ARCHITECTURE RTL;

