library ieee;
  use std.textio.all;
  use ieee.std_logic_textio.all;

ARCHITECTURE hexRead OF bram IS
    -- Define ramContent type
  type ramContentType is array(0 to (2**addressBitNb)-1) of std_logic_vector(dataBitNb-1 DOWNTO 0);

  -- Define function to create initvalue signal
  impure function ReadRamContentFromFile(ramContentFilenAme : in string) return ramContentType is
    FILE     ramContentFile     : text is in ramContentFilenAme;
    variable ramContentFileLine : line;
    variable ramContent         : ramContentType;
  begin
    for i in ramContentType'range loop
      readline(ramContentFile, ramContentFileLine);
      HREAD(ramContentFileLine, ramContent(i));
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
          ramContent(to_integer(unsigned(addressIn))) := std_logic_vector(dataIn);
        else
          dataOut <= to_stdulogicvector(ramContent(to_integer(unsigned(addressIn))));
        end if;
      end if;
    end if;
  end process;

END ARCHITECTURE hexRead;
