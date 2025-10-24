-- ------------------------------------------------------------------------------
--  Copyright 2013 HES-SO Valais Wallis (www.hevs.ch)
-- ------------------------------------------------------------------------------
--  FIFO bridge with bus width adaption 
--    A shift register that connects two FIFOs with different bus width.
--    Many IP blocks nowadays have FIFO or FIFO-like interface. But the bus width
--    varies often. This block can the be used to adapt the bus width to your own
--    needs.
--    The Tx side bus width has to be a multiple of the Rx side bus width. 
--
--    Created on 2013-10-21
-- 
--    Version: 1.0
--    Author: Oliver A. Gubler (oliver.gubler@hevs.ch)
-- ------------------------------------------------------------------------------
--

library common;
  use common.commonlib.all;

ARCHITECTURE behavioral OF fifoBridgeRxToTxBusWidthAdaptionTxbigger IS
  
  constant ratio_txrx_c: positive range 1 to dataBitNbTx/dataBitNbRx:= dataBitNbTx/dataBitNbRx;

  signal cnt_s: unsigned(requiredBitNb(ratio_txrx_c-1)-1 downto 0);
  signal shiftreg_s: std_ulogic_vector(dataBitNbTx-1 downto 0);
  signal fullTx_s: std_ulogic;
  signal emptyRx_s: std_ulogic;
      
BEGIN
  
  rx0: process(clock, reset)
  begin
    if reset = '1' then
      shiftreg_s <= (others => '0');
      readRx <= '1';
      emptyRx_s <= '1';
      cnt_s <= (others => '0');
    elsif rising_edge(clock) then
      readRx <= NOT fullTx_s;
      emptyRx_s <= '1';
      if emptyRx = '0' and fullTx_s = '0' then
--        shiftreg_s(((to_integer(cnt_s)+1)*dataBitNbRx)-1 downto to_integer(cnt_s)*dataBitNbRx) <= dataRx;
        shiftreg_s <= shiftreg_s(dataBitNbTx-dataBitNbRx-1 downto 0) & dataRx;
        readRx <= '1';
        cnt_s <= cnt_s +1;
        if cnt_s >= ratio_txrx_c-1 then
          cnt_s <= (others => '0');
          emptyRx_s <= '0';
        end if;
      end if;  
    end if;   
  end process;
  
  tx0: process(clock, reset)
  begin
    if reset = '1' then
      fullTx_s <= '1';
      writeTx <= '0';
      dataTx <= (others => '0');
    elsif rising_edge(clock) then
      fullTx_s <= fullTx;
      writeTx <= '0';
      -- no need to wait to check for full (in contrast to RxBigger)
      -- because it will forcibly take several clocks to fill the shiftreg
      if emptyRx_s = '0' and fullTx = '0' then
        dataTx <= shiftreg_s;
        writeTx <= '1';
      end if;
    end if;
  end process;  
  
END ARCHITECTURE behavioral;


