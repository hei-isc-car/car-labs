ARCHITECTURE sim OF registerULogicVectorTo IS
BEGIN

  registerData: process(reset, clock)
  begin
    if reset = '1' then
      dataOut <= (others => '0') after delay;
    elsif rising_edge(clock) then
      if enable = '1' then
        dataOut <= dataIn after delay;
      end if;
    end if;
  end process registerData;

END ARCHITECTURE sim;

