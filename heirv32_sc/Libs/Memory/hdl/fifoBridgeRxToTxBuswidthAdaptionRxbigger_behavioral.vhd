-- ------------------------------------------------------------------------------
--  Copyright 2013 HES-SO Valais Wallis (www.hevs.ch)
-- ------------------------------------------------------------------------------
--  FIFO bridge with bus width adaption 
--    A shift register that connects two FIFOs with different bus width.
--    Many IP blocks nowadays have FIFO or FIFO-like interfaces and often they
--    have to be connected. This block can the be used for this task, even if
--    the bus size of the two FIFO interfaces is different.
--    The Rx side bus width has to be a multiple of the Tx side bus width. 
-- 
--    Created on 2013-10-18
--
--    Author: Oliver A. Gubler (oliver.gubler@hevs.ch)
-- 
--    2014-10-06: *modify introduction text
--                +add some comment
--                *change readRx to a pulse
--                *fix bug on shift of shiftreg_s
--    2013-10-18: +intital release
-- ------------------------------------------------------------------------------
--

library Common; 
  use Common.CommonLib.all; 

ARCHITECTURE behavioral OF fifoBridgeRxToTxBusWidthAdaptionRxBigger IS
  
  signal cnt_s: unsigned(requiredBitNb(dataBitNbRx)-1 downto 0);
  signal shiftreg_s: std_ulogic_vector(dataBitNbRx-1 downto 0);
  signal emptyRx_s: std_ulogic; -- internal empty signal
  signal writeTx_s: std_ulogic; -- internal write signal
  
  constant ratio_rxtx_c: positive range 1 to dataBitNbRx/dataBitNbTx:= dataBitNbRx/dataBitNbTx;
    
BEGIN
  
  rx0: process(clock, reset)
  begin
    if reset = '1' then
      shiftreg_s <= (others => '0');
      emptyRx_s <= '1';
      cnt_s <= (others => '0');
      writeTx_s <= '0';
      dataTx <= (others => '0');
      readRx <= '0';
    elsif rising_edge(clock) then
      writeTx_s <= '0';
      readRx <= '0';
      -- fetch data
      if emptyRx_s = '1' and emptyRx = '0' then
        emptyRx_s <= '0';
        shiftreg_s <= dataRx;
        readRx <= '1';
      end if;
      -- shift data and put out
      -- after each write, wait one cylce to check if full gets high
      if emptyRx_s = '0' and fullTx = '0' and writeTx_s = '0' then
        shiftreg_s <= shiftreg_s(dataBitNbRx-dataBitNbTx-1 downto 0) & std_ulogic_vector(to_unsigned(0,dataBitNbTx));
        dataTx <= shiftreg_s(dataBitNbRx-1 downto dataBitNbRx-dataBitNbTx);
        writeTx_s <= '1';
        cnt_s <= cnt_s +1;
        if cnt_s >= ratio_rxtx_c-1 then
          cnt_s <= (others => '0');
          emptyRx_s <= '1';
        end if;
      end if;  
    end if;
  end process;

  writeTx <= writeTx_s;

END ARCHITECTURE behavioral;

