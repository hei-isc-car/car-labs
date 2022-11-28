USE std.textio.all;

ARCHITECTURE bhv OF bramDualport IS
  -- Define ramContent type
  type ramContentType is array(0 to (2**addressBitNb)-1) of bit_vector(dataBitNb-1 DOWNTO 0);

  -- Declare ramContent signal
  shared variable ramContent: ramContentType;

BEGIN
  -- Port A
  process(clockA)
  begin
    if clockA'event and clockA='1' then
      if enA = '1' then
        if writeEnA = '1' then
          dataOutA <= dataInA;
          ramContent(to_integer(unsigned(addressA))) := to_bitvector(dataInA,'0');
        else
          dataOutA <= to_stdulogicvector(ramContent(to_integer(unsigned(addressA))));
        end if;
      end if;
    end if;
  end process;

  -- Port B
  process(clockB)
  begin
    if clockB'event and clockB='1' then
      if enB = '1' then
        if writeEnB = '1' then
          ramContent(to_integer(unsigned(addressB))) := to_bitvector(dataInB,'0');
          dataOutB <= dataInB;
        else
          dataOutB <= to_stdulogicvector(ramContent(to_integer(unsigned(addressB))));
        end if;
      end if;
    end if;
  end process;

END ARCHITECTURE bhv;
