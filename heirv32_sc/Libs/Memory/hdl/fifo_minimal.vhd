library Common;
  use Common.CommonLib.all;

architecture minimal of FIFO_bram is

  subtype register_type is std_ulogic_vector(dataIn'high downto 0);
  type memory_type is array (0 to depth-1) of register_type;

  signal writeCounter: unsigned(requiredBitNb(depth)-1 downto 0);
  signal readCounter: unsigned(writeCounter'range);
  signal memoryArray : memory_type;

begin

  updateWriteCounter: process(reset, clock)
  begin
    if reset = '1' then
      writeCounter <= (others => '0');
    elsif rising_edge(clock) then
      if write = '1' then
        writeCounter <= writeCounter + 1;
      end if;
    end if;
  end process updateWriteCounter;

  updateReadCounter: process(reset, clock)
  begin
    if reset = '1' then
      readCounter <= (others => '0');
    elsif rising_edge(clock) then
      if read = '1' then
        readCounter <= readCounter + 1;
      end if;
    end if;
  end process updateReadCounter;

  writeMem: process(clock)
  begin
    if rising_edge(clock) then
      if write = '1' then
        memoryArray(to_integer(writeCounter)) <= dataIn;
      end if;
    end if;
  end process writeMem;

  dataOut <= memoryArray(to_integer(readCounter));

  checkStatus: process(readCounter, writeCounter)
  begin
    if readCounter = writeCounter then
      empty <= '1';
    else
      empty <= '0';
    end if;
    if writeCounter+1 = readCounter then
      full <= '1';
    else
      full <= '0';
    end if;
  end process checkStatus;

end minimal;

