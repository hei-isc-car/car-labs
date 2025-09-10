ARCHITECTURE RTL OF sdramControllerBuildAddress IS

  constant addressPrecharge: std_ulogic_vector(memAddress'range)
                           := (10=> '1', others => '-');
  constant addressModeRegU : unsigned(memAddress'range)
                           := resize("0" & "00" & "010" & "0" & "000", memAddress'length);
    -- ll,10 = reserved,
    -- 9 = '0' programmed burst length => burst length applicable for both rd and wr
    -- 8,7 = Op mode = 00 => standard operation (all other states are reserved)
    -- 6,5,4 = CAS latency = 010 => cas latency of 2
    -- 3 = Burst Type = '0' => Sequential (not interleaved)
    -- 2,1,0 = Brust Length = 000 => brust length is 1
  constant addressModeReg  : std_ulogic_vector(memAddress'range)
                           := std_ulogic_vector(addressModeRegU);

BEGIN

  buildAddresses: process(ramAddr, addrSelPrecharge, addrSelModeReg, addrSelRow, addrSelCol)
  begin
    memBankAddress <= std_ulogic_vector(ramAddr(ramAddr'high downto ramAddr'high-memBankAddress'length+1));
    if addrSelPrecharge = '1' then
      memAddress <= addressPrecharge;
    elsif addrSelModeReg = '1' then
      memAddress <= addressModeReg;
    elsif addrSelRow = '1' then
      memAddress <= std_ulogic_vector(ramAddr(rowAddressBitNb+colAddressBitNb-1 downto colAddressBitNb));
    elsif addrSelCol = '1' then
      memAddress(memAddress'high downto colAddressBitNb) <= (others => '0');
      memAddress(10) <= '1';
      memAddress(colAddressBitNb-1 downto 0) <= std_ulogic_vector(ramAddr(colAddressBitNb-1 downto 0));
    else
      memAddress <= (others => '-');
    end if;
  end process buildAddresses;

END ARCHITECTURE RTL;
