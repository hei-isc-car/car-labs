LIBRARY Common;
  USE Common.CommonLib.all;

ARCHITECTURE RTL OF freqDividerEnable IS

  signal count: unsigned(requiredBitNb(divideValue)-1 downto 0);

BEGIN

  countEndlessly: process(reset, clock)
  begin
    if reset = '1' then
      count <= (others => '0');
    elsif rising_edge(clock) then
      if enIn = '1' then
        if count = 0 then
          count <= to_unsigned(divideValue-1, count'length);
        else
          count <= count-1 ;
        end if;
      end if;
    end if;
  end process countEndlessly;

  enOut <= '1' after delay when count = 0
    else '0' after delay;

END ARCHITECTURE RTL;
