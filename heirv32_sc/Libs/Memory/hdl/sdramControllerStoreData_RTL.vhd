ARCHITECTURE RTL OF sdramControllerStoreData IS
BEGIN

  storeData : process(reset, clock)
  begin
    if reset = '1' then
      memDataOut <= (others => '0');
    elsif rising_edge(clock) then
      memDataOut <= ramDataOut;
    end if;
  end process storeData;

END ARCHITECTURE RTL;

