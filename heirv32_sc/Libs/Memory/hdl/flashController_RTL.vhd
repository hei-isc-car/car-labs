ARCHITECTURE RTL OF flashController IS

  signal addressReg: unsigned(flashAddr'range);
  signal dataOutReg: std_ulogic_vector(flashDataOut'range);
  signal dataInReg: std_ulogic_vector(flashDataIn'range);
  type sequenceStateType is (
    idle,
    waitForBus1, waitForBus0,
    startAccess, waitAcccessEnd
  );
  signal sequenceState: sequenceStateType;
  signal read: std_ulogic;
  signal startCounter: std_ulogic;
  signal sequenceCounter: unsigned(3 downto 0);
  signal endOfCount: std_ulogic;
  signal readDataValid: std_ulogic;
  signal flashCE: std_ulogic;

BEGIN
  ------------------------------------------------------------------------------
                                                                 -- memory reset
  memRst_n <= not '0';

  ------------------------------------------------------------------------------
                                                                      -- address
  storeAddress: process(reset, clock)
  begin
    if reset = '1' then
      addressReg <= (others => '0');
    elsif rising_edge(clock) then
      if (flashRd = '1') or (flashWr = '1') then
        addressReg <= shift_left(flashAddr, 1);
      end if;
    end if;
  end process storeAddress;

  memAddress <= std_ulogic_vector(addressReg);

  ------------------------------------------------------------------------------
                                                                     -- data out
  storeDataOut: process(reset, clock)
  begin
    if reset = '1' then
      dataOutReg <= (others => '0');
    elsif rising_edge(clock) then
      if flashWr = '1' then
        dataOutReg <= flashDataOut;
      end if;
    end if;
  end process storeDataOut;

  memDataOut <= flashDataOut;

  ------------------------------------------------------------------------------
                                                                     -- data in
  readDataValid <= '1' when (read = '1') and (endOfCount = '1') else '0';

  storeDataIn: process(reset, clock)
  begin
    if reset = '1' then
      dataInReg <= (others => '0');
    elsif rising_edge(clock) then
      if readDataValid = '1' then
        dataInReg <= memDataIn;
      end if;
    end if;
  end process storeDataIn;

  flashDataIn <= dataInReg when readDataValid = '0' else memDataIn;

  ------------------------------------------------------------------------------
                                                          -- read/write sequence
  busAccessFsm: process(reset, clock)
  begin
    if reset = '1' then
      read <= '0';
      sequenceState <= idle;
    elsif rising_edge(clock) then
      case sequenceState is
        when idle =>
          if flashRd = '1' then
            read <= '1';
            sequenceState <= waitForBus1;
          elsif flashWr = '1' then
            read <= '0';
            sequenceState <= waitForBus1;
          end if;
        when waitForBus1 =>
          if memBusEn_n = '1' then
            sequenceState <= waitForBus0;
          end if;
        when waitForBus0 =>
          if memBusEn_n = '0' then
            sequenceState <= startAccess;
          end if;
        when startAccess =>
          sequenceState <= waitAcccessEnd;
        when waitAcccessEnd =>
          if endOfCount = '1' then
            sequenceState <= idle;
          end if;
      end case;
    end if;
  end process busAccessFsm;


  startCounter <= '1' when sequenceState = startAccess else '0';
  endOfCount <= '1'
    when ( (sequenceCounter = rdWaitState) and (read = '1') ) or
         ( (sequenceCounter = wrWaitState) and (read = '0') )
    else '0';

  countSequence: process(reset, clock)
  begin
    if reset = '1' then
      sequenceCounter <= (others => '0');
    elsif rising_edge(clock) then
      if sequenceCounter = 0 then
        if startCounter = '1' then
          sequenceCounter <= sequenceCounter + 1;
        end if;
      else
        if endOfCount = '1' then
          sequenceCounter <= (others => '0');
        else
          sequenceCounter <= sequenceCounter + 1;
        end if;
      end if;
    end if;
  end process countSequence;

  flashCE <= '0' when sequenceCounter = 0 else '1';
  flashCE_n <= not flashCE;
  memWR_n <= not '1' when (read = '0') and (flashCE = '1') and (endOfCount = '0')
    else not '0';
  memOE_n <= not '1' when (read = '1') and (flashCE = '1') else not '0';

  flashDataValid <= endOfCount;

END ARCHITECTURE RTL;
