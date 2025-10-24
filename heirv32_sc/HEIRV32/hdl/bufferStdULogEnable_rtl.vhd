
ARCHITECTURE rtl OF bufferStdULogEnable IS
BEGIN

    buffering:process(rst, CLK)
	begin
		if rst = '1' then
			out1 <= (others=>'0');
		elsif rising_edge(CLK) then
			if EN = '1' then
				out1 <= in1;
			end if;
		end if;
	end process buffering;
	
END ARCHITECTURE rtl;

