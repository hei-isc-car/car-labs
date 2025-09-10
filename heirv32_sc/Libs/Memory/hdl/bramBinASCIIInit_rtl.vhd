USE std.textio.all;

ARCHITECTURE rtl OF bramBinASCIIInit IS
  -- Define ramContent type
  type ramContentType is array(0 to (2**addressBitNb)-1) of bit_vector(dataBitNb-1 DOWNTO 0);

  -- Define function to create initvalue signal
  impure function ReadRamContentFromFile(ramContentFilenAme : in string) return ramContentType is
    FILE     ramContentFile     : text is in ramContentFilenAme;
    variable ramContentFileLine : line;
    variable ramContent         : ramContentType;
  begin
    for i in ramContentType'range loop
      readline(ramContentFile, ramContentFileLine);
      read(ramContentFileLine, ramContent(i));
    end loop;
    return ramContent;
  end function;

  -- Declare ramContent signal
  shared variable ramContent: ramContentType := ReadRamContentFromFile(initFile);

BEGIN
  -- Port A
  process(clock)
  begin
    if clock'event and clock='1' then
      if en = '1' then
        if writeEn = '1' then
          dataOut <= dataIn;
          ramContent(to_integer(unsigned(addressIn))) := to_bitvector(dataIn,'0');
        else
          dataOut <= to_stdulogicvector(ramContent(to_integer(unsigned(addressIn))));
        end if;
      end if;
    end if;
  end process;

END ARCHITECTURE rtl;
