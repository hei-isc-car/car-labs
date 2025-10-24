-- ------------------------------------------------------------------------------
--  Copyright 2012 HES-SO Valais Wallis (www.hevs.ch)
-- ------------------------------------------------------------------------------
--  FIFO bridge with bus width adaptation 
--    A register that connects two FIFOs.
--    Many IP blocks nowadays have FIFO or FIFO-like interfaces and often they
--    have to be connected. This block can the be used for this task.
-- 
--    Created on 2012
--
--    Author: Oliver A. Gubler (oliver.gubler@hevs.ch)
-- 
--    2016-04-01: fix bug in FWFT read when full
--    2016-03-22: +add FirstWordFallThrough (FWFT) generic
--    2012: +intital release
-- ------------------------------------------------------------------------------
--

ARCHITECTURE RTL OF fifoBridgeRxToTx IS

  signal read1: std_ulogic;
  signal read2: std_ulogic;
  signal read: std_ulogic;
  signal storedData: std_ulogic_vector(data1'range);
  signal write: std_ulogic;

BEGIN

  readControl: process(reset, clock)
  begin
    if reset = '1' then
      read1 <= '0';
      read2 <= '0';
    elsif rising_edge(clock) then
      if (empty1 = '0') and (full2 = '0') then
        read1 <= '1';
      else
        read1 <= '0';
      end if;
      read2 <= read1;
    end if;
  end process readControl;

  read <= not empty1 and not full2 when firstWordFallThrough 
          else not empty1 and read1;
  rd1 <= read;

  readData: process(reset, clock)
  begin
    if reset = '1' then
      storedData <= (others => '0');
  elsif rising_edge(clock) then
      if firstWordFallThrough then
        storedData <= data1;
      else
        if read = '1' then
          storedData <= data1;
        end if;
      end if;
    end if;
  end process readData;

  data2 <= storedData;

  writeControl: process(reset, clock)
  begin
    if reset = '1' then
      write <= '0';
  elsif rising_edge(clock) then
      if firstWordFallThrough then
        write <= not empty1 and not full2;
      else
        if read = '1' then
          write <= '1';
        else
          write <= '0';
        end if;
      end if;
    end if;
  end process writeControl;

  wr2 <= write;

end RTL;
