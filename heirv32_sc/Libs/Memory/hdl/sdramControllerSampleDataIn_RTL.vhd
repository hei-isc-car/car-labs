ARCHITECTURE RTL OF sdramControllerSampleDataIn IS
BEGIN

  sampleRamData: process(reset, clock)
  begin
    if reset = '1' then
      ramDataIn <= (others => '0');
    elsif falling_edge(clock) then
      if sampleData = '1' then
        ramDataIn <= memDataIn;
      end if;
    end if;
  end process sampleRamData;


END ARCHITECTURE RTL;

