ARCHITECTURE bhv OF bram IS

  type ramContentType is array(2**addressBitNb-1 downto 0) of std_logic_vector(dataBitNb-1 DOWNTO 0);
  shared variable ramContent: ramContentType ;

BEGIN

  process(clock)
  begin
    if rising_edge(clock) then
      if en = '1' then
        if writeEn = '1' then
          ramContent(to_integer(unsigned(addressIn))) := dataIn;
        end if;
        dataOut <= ramContent(to_integer(unsigned(addressIn)));
      end if;
    end if;
  end process;

END ARCHITECTURE bhv;
