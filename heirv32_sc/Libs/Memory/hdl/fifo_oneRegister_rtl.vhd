architecture oneRegister of FIFO_oneRegister is

  signal dataRegister: std_ulogic_vector(dataIn'range);

begin

  writeReg: process(reset, clock)
  begin
    if reset = '1' then
      dataRegister <= (others => '0');
    elsif rising_edge(clock) then
      if write = '1' then
        dataRegister <= dataIn;
      end if;
    end if;
  end process writeReg;

  dataOut <= dataRegister;

  manageFlags: process(reset, clock)
  begin
    if reset = '1' then
      empty <= '1';
      full  <= '0';
    elsif rising_edge(clock) then
      if write = '1' then
        empty <= '0';
        full  <= '1';
      elsif read = '1' then
        empty <= '1';
        full  <= '0';
      end if;
    end if;
  end process manageFlags;

end oneRegister;

