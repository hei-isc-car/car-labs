library Common;
  use Common.CommonLib.all;

architecture RTL of FIFO_bram is

  subtype register_type is std_ulogic_vector(dataIn'high downto 0);
  type memory_type is array (0 to depth-1) of register_type;

  signal writeCounter: unsigned(requiredBitNb(depth-1)-1 downto 0);
  signal readCounter: unsigned(writeCounter'range);
  signal memoryArray: memory_type;

  type fifoStateType is (
    sEmpty, sFull,
    sRead, sWrite, sWriteFirst,
    sReadWrite, sWait
  );
  signal fifoState: fifoStateType;
  signal emptyCondition, fullCondition, empty_int: std_ulogic;

begin
  ------------------------------------------------------------------------------
                                                      -- read and write counters
  updateWriteCounter: process(reset, clock)
  begin
    if reset = '1' then
      writeCounter <= (others => '0');
    elsif rising_edge(clock) then
      if (write = '1') and  (fullCondition = '0') then
        writeCounter <= writeCounter + 1;
      end if;
    end if;
  end process updateWriteCounter;

  updateReadCounter: process(reset, clock)
  begin
    if reset = '1' then
      readCounter <= (others => '0');
    elsif rising_edge(clock) then
      if (read = '1') and  (empty_int = '0') then
        readCounter <= readCounter + 1;
      end if;
    end if;
  end process updateReadCounter;

  ------------------------------------------------------------------------------
                                                                -- memory access
  writeMem: process(clock)
  begin
    if rising_edge(clock) then
      if (write = '1') and (fullCondition = '0') then
        memoryArray(to_integer(writeCounter)) <= dataIn;
      end if;
    end if;
  end process writeMem;

  readMem: process(reset, clock)
  begin
    if reset = '1' then
      dataOut <= (others => '0');
    elsif rising_edge(clock) then
      if (read = '0') or (empty_int = '1') then
        dataOut <= memoryArray(to_integer(readCounter));
      else
        dataOut <= memoryArray(to_integer(readCounter+1));
      end if;
    end if;
  end process readMem;

  ------------------------------------------------------------------------------
                                                                     -- controls
  emptyCondition <= '1' when
      ( (fifoState = sRead) and (writeCounter = readCounter) ) or
        (fifoState = sEmpty)
    else '0';

  fullCondition <= '1' when
      ( (fifoState = sWrite) and (writeCounter = readCounter) ) or
        (fifoState = sFull)
    else '0';


  fifoControl: process(reset, clock)
  begin
    if reset = '1' then
      fifoState <= sEmpty;
    elsif rising_edge(clock) then
      case fifoState is
        when sEmpty =>
          if write = '1' then
            fifoState <= sWriteFirst;
          end if;
        when sFull =>
          if (read = '1') then
            fifoState <= sRead;
          end if;
        when sRead =>
          if (read = '1') and (write = '1') then
            fifoState <= sReadWrite;
          elsif write = '1' then
            fifoState <= sWrite;
		      elsif emptyCondition = '1' then
            fifoState <= sEmpty;
          elsif read = '1' then
            fifoState <= sRead;
          else
            fifoState <= sWait;
          end if;
        when sWriteFirst =>
          if (read = '1') and (write = '1') then
            fifoState <= sReadWrite;
          elsif write = '1' then
            fifoState <= sWrite;
          elsif read = '1' then
            fifoState <= sRead;
          else
            fifoState <= sWait;
          end if;
        when sWrite =>
          if (read = '1') and (write = '1') then
            fifoState <= sReadWrite;
          elsif read = '1' then
            fifoState <= sRead;
		      elsif fullCondition = '1' then
            fifoState <= sFull;
          elsif write = '1' then
            fifoState <= sWrite;
          else
            fifoState <= sWait;
          end if;
        when sReadWrite =>
          if (read = '0') and (write = '0') then
            fifoState <= sWait;
          elsif (read = '1') and (write = '0') then
            fifoState <= sRead;
          elsif (write = '1') and (read = '0') then
            fifoState <= sWrite;
          end if;
        when sWait =>
          if (read = '1') and (write = '1') then
            fifoState <= sReadWrite;
          elsif read = '1' then
            fifoState <= sRead;
          elsif write = '1' then
            fifoState <= sWrite;
          end if;
        when others => null;
      end case;
    end if;
  end process fifoControl;
  

  full <= '1' when 
        (fifoState = sFull) or
        (fullCondition = '1')
    else '0';

  empty_int <= '1' when
        (fifoState = sEmpty) or
        (fifoState = sWriteFirst) or
        ( (emptyCondition = '1') and (fifoState = sRead) )
    else '0';
  empty <= empty_int;
  
end RTL;
