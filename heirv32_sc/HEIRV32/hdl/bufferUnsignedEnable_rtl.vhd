
ARCHITECTURE rtl OF bufferUnsignedEnable IS
BEGIN

    buffering:process(rst, CLK)
	begin
		if rst = '1' then
			out1 <= (others=>'0') after g_tPC;
		elsif rising_edge(CLK) then
			if EN = '1' then
				out1 <= in1 after g_tPC;
			end if;
		end if;
	end process buffering;

END ARCHITECTURE rtl;
