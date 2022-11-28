--------------------------------------------------------------------------------
-- Copyright 2012 HES-SO Valais Wallis (www.hevs.ch)
--------------------------------------------------------------------------------
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
-- -----------------------------------------------------------------------------
-- Common Lib
--
-- -----------------------------------------------------------------------------
--  Authors:
--    cof: [François Corthay](francois.corthay@hevs.ch)
--    guo: [Oliver A. Gubler](oliver.gubler@hevs.ch)
-- -----------------------------------------------------------------------------
-- Changelog:
--   2016-06 : guo
--     added function sel
--   2015-06 : guo
--     added counterBitNb
--     added documentation
-- -----------------------------------------------------------------------------
library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

PACKAGE CommonLib IS

  ------------------------------------------------------------------------------
  -- Returns the number of bits needed to represent the given val
  -- Examples:
  --   requiredBitNb(1) = 1   (1)
  --   requiredBitNb(2) = 2   (10)
  --   requiredBitNb(3) = 2   (11)
  function requiredBitNb(val : integer) return integer;

  ------------------------------------------------------------------------------
  -- Returns the number of bits needed to count val times (0 to val-1)
  -- Examples:
  --   counterBitNb(1) = 1    (0)
  --   counterBitNb(2) = 1    (0->1)
  --   counterBitNb(3) = 2    (0->1->10)
  function counterBitNb(val : integer) return integer;

  ------------------------------------------------------------------------------
  -- Functions to return one or the other input based on a boolean.
  -- Can be used to build conditional constants.
  -- Example:
  --   constant bonjour_c : string := sel(ptpRole = master, "fpga20", "fpga02");
  function sel(Cond : BOOLEAN; If_True, If_False : integer)
                                            return integer;
  function sel(Cond : BOOLEAN; If_True, If_False : string)
                                            return string;
  function sel(Cond : BOOLEAN; If_True, If_False : std_ulogic_vector)
                                            return std_ulogic_vector;
  function sel(Cond : BOOLEAN; If_True, If_False : unsigned)
                                            return unsigned;
  function sel(Cond : BOOLEAN; If_True, If_False : signed)
                                            return signed;

END CommonLib;
