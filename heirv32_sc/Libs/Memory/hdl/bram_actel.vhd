ARCHITECTURE actel OF bram IS

  subtype ramCellType is std_ulogic_vector(dataBitNb-1 DOWNTO 0);
  type ramContentType is array(2**addressBitNb-1 downto 0) of ramCellType;
  signal ramContent: ramContentType ;

BEGIN
                                                                 -- memory array
  process(clock)
  begin
    if rising_edge(clock) then
      if (en = '1') and (writeEn = '1') then
        ramContent(to_integer(unsigned(addressIn))) <= dataIn;
      end if;
    end if;
  end process;
                                                                -- read register
  process(clock)
  begin
    if rising_edge(clock) then
      if en = '1' then
        dataOut <= ramContent(to_integer(unsigned(addressIn)));
      end if;
    end if;
  end process;

END ARCHITECTURE actel;
