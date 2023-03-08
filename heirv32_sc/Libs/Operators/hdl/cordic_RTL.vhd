library ieee;
  use ieee.math_real.all;
library Common;
  use Common.CommonLib.all;

ARCHITECTURE RTL OF cordicPipelined IS

  constant iterationNb: positive := signalBitNb+2;

  subtype registerType is signed(signalBitNb-1+1 downto 0);
  type    registerArrayType is array (1 to iterationNb) of registerType;

  constant registerXInit: registerType := to_signed(
        integer(amplitude*0.6071*2.0**(signalBitNb-1)), registerType'length);
  constant registerYInit: registerType := to_signed(0, registerType'length);

  subtype phaseType is signed(phaseBitNb-1 downto 0);
  type phaseArrayType is array (1 to iterationNb) of phaseType;
  type directionArrayType is array(1 to iterationNb) of std_ulogic;
  type phaseSignArrayType is array(1 to iterationNb) of std_ulogic;


  function initPhaseArray return phaseArrayType is
    variable phaseIncrement: phaseArrayType;
  begin
    for index in 1 to phaseIncrement'length loop
      phaseIncrement(index) := to_signed(integer( arctan(1.0/2.0**(index-1)) / math_pi * 2.0**(phaseBitNb-1) ), phaseBitNb);
    end loop;
    return phaseIncrement;
  end initPhaseArray;

  constant phaseIncrement: phaseArrayType := initPhaseArray;
  signal phaseSign     : phaseSignArrayType;

  signal registerX     : registerArrayType;
  signal registerY     : registerArrayType;
  signal angle         : phaseArrayType;
  signal direction     : directionArrayType;

  signal cosine_int    : registerType;

BEGIN

  rotate: process(reset, clock)
  begin
    if reset = '1' then
      registerX <= (others => (others => '0'));
      registery <= (others => (others => '0'));
    elsif rising_edge(clock) then
      registerX(1) <= registerXInit;
      registerY(1) <= registerYInit;
      for index in 1 to iterationNb-1 loop
        if direction(index) = '0' then
          registerX(index+1) <= registerX(index) - shift_right(registerY(index), index-1);
          registerY(index+1) <= registerY(index) + shift_right(registerX(index), index-1);
        else
          registerX(index+1) <= registerX(index) + shift_right(registerY(index), index-1);
          registerY(index+1) <= registerY(index) - shift_right(registerX(index), index-1);
        end if;
      end loop;
    end if;
  end process rotate;

  trackAngle: process(reset, clock)
  begin
    if reset = '1' then
      angle <= (others => (others => '0'));
      phaseSign <= (others => '0');
    elsif rising_edge(clock) then
      if ( phase(phase'high) xor phase(phase'high-1) ) = '0' then
        angle(1) <= signed(phase);
      else
        angle(1)(angle(1)'high) <= phase(phase'high);
        angle(1)(angle(1)'high-1 downto 0) <= signed(not phase(phase'high-1 downto 0));
      end if;

      phaseSign(1) <= not(phase(phase'high) xor phase(phase'high-1));

      for index in 1 to iterationNb-1 loop
        phaseSign(index+1) <= phaseSign(index);
        if direction(index) = '0' then
          angle(index+1) <= angle(index) - phaseIncrement(index);
        else
          angle(index+1) <= angle(index) + phaseIncrement(index);
        end if;
      end loop;
    end if;
  end process trackAngle;

  dir: process(angle)
  begin
    for index in 1 to iterationNb loop
      direction(index) <= angle(index)(angle(index)'high);
    end loop;
  end process dir;

  sine <= to_signed((2**(sine'length-1)-1), sine'length) when (registerY(iterationNb) >= (2**(sine'length-1)))
     else to_signed(-(2**(sine'length-1)-1), sine'length) when (registerY(iterationNb) <= -(2**(sine'length-1)))
     else registerY(iterationNb)(sine'range);

  cosine_int <= registerX(iterationNb) when (phaseSign(iterationNb) = '1')
       else not registerX(iterationNb);

  cosine <= to_signed((2**(cosine'length-1)-1), cosine'length) when (cosine_int >= (2**(cosine'length-1)))
     else to_signed(-(2**(cosine'length-1)-1), cosine'length) when (cosine_int <= -(2**(cosine'length-1)))
     else cosine_int(cosine'range);

END ARCHITECTURE RTL;
