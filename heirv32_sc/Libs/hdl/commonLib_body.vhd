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
-- Often used functions
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
-- -----------------------------------------------------------------------------
PACKAGE BODY CommonLib IS

  function requiredBitNb (val : integer) return integer is
    variable powerOfTwo, bitNb : integer;
  begin
    powerOfTwo := 1;
    bitNb := 0;
    while powerOfTwo <= val loop
      powerOfTwo := 2 * powerOfTwo;
      bitNb := bitNb + 1;
    end loop;
    return bitNb;
  end requiredBitNb;

  function counterBitNb (val : integer) return integer is
    variable powerOfTwo, bitNb : integer;
  begin
    powerOfTwo := 1;
    bitNb := 0;
    while powerOfTwo < val loop
      powerOfTwo := 2 * powerOfTwo;
      bitNb := bitNb + 1;
    end loop;
    return bitNb;
  end counterBitNb;

  function sel(Cond : BOOLEAN; If_True, If_False : integer)
                                            return integer is
  begin
    if (Cond = TRUE) then
      return (If_True);
    else
      return (If_False);
    end if;
  end function sel;

  function sel(Cond : BOOLEAN; If_True, If_False : string)
                                            return string is
  begin
    if (Cond = TRUE) then
      return (If_True);
    else
      return (If_False);
    end if;
  end function sel;

  function sel(Cond : BOOLEAN; If_True, If_False : std_ulogic_vector)
                                            return std_ulogic_vector is
  begin
    if (Cond = TRUE) then
      return (If_True);
    else
      return (If_False);
    end if;
  end function sel;

  function sel(Cond : BOOLEAN; If_True, If_False : unsigned)
                                            return unsigned is
  begin
    if (Cond = TRUE) then
      return (If_True);
    else
      return (If_False);
    end if;
  end function sel;

  function sel(Cond : BOOLEAN; If_True, If_False : signed)
                                            return signed is
  begin
    if (Cond = TRUE) then
      return (If_True);
    else
      return (If_False);
    end if;
  end function sel;

END CommonLib;
