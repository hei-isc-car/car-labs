
ARCHITECTURE rtl OF registerFile IS
    -- Bank of register
    type t_registersBank is array (31 downto 0) of
        std_ulogic_vector(31 downto 0);
    -- A bank of registers
    signal larr_registers: t_registersBank;
    signal lvec_btns : std_ulogic_vector(31 downto 0);
BEGIN
    -- Special regs
    process(rst, clk)
    begin
        if rst = '1' then
            lvec_btns <= (others => '0');
        elsif rising_edge(clk) then
            lvec_btns <= (btns'length to g_datawidth-1 => '0') & btns;
        end if;
    end process;

    -- Clocked write
    process(rst, clk) begin
    if rst = '1' then
        larr_registers <= (others => (others => '0')) after g_tRfWr;
    elsif rising_edge(clk) then
        if writeEnable3 = '1' and en = '1' then
            larr_registers(to_integer(unsigned(addr3))) <= writeData after (g_tRfWr + g_tSetup);
        end if;
    end if;
    end process;

    -- Comb. read
    -- Addr 0 wired to 0s
    process(addr1, addr2) begin
        if (to_integer(unsigned(addr1)) = 0) then
            RD1 <= (others => '0') after g_tRfRd;
        elsif (to_integer(unsigned(addr1)) = 31) then -- buttons
            RD1 <= lvec_btns after g_tRfRd;
        else
            RD1 <= larr_registers(to_integer(unsigned(addr1))) after g_tRfRd;
        end if;

        if (to_integer(unsigned(addr2)) = 0) then
            RD2 <= (others => '0') after g_tRfRd;
        elsif (to_integer(unsigned(addr2)) = 31) then -- buttons
            RD2 <= lvec_btns after g_tRfRd;
        else
            RD2 <= larr_registers(to_integer(unsigned(addr2))) after g_tRfRd;
        end if;
    end process;

    leds <= larr_registers(30);

END ARCHITECTURE rtl;
