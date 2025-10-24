
ARCHITECTURE rtl OF dataMemory IS

  -- Bank of data
  type t_dataBank is array (0 to (2**g_memoryNbBits)-1) of
    std_ulogic_vector(g_dataWidth-1 downto 0);
  -- A bank of data
  signal larr_data: t_dataBank;

BEGIN

  process(rst, clk)
  begin
    if rst = '1' then
      larr_data <= (others => (others => '0')) after g_tMemWr;
    elsif rising_edge(clk) then
      if en = '1' and writeEn = '1' then
        -- skip the two last bits (since we do only +4)
        larr_data(to_integer(unsigned(
          address(g_memoryNbBits+1 downto 2)
        ))) <= writeData after (g_tMemWr + g_tSetup);
      end if;
    end if;
  end process;

  -- Comb. read
    -- skip the two last bits (since we do only +4)
  readData <= larr_data(to_integer(unsigned(
    address(g_memoryNbBits+1 downto 2)
  ))) after g_tMemRd;

END ARCHITECTURE rtl;
