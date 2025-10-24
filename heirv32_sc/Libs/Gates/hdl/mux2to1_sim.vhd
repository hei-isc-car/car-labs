ARCHITECTURE sim OF mux2to1 IS
  subtype tSelect is std_uLogic_vector(0 to 2);
BEGIN

  muxSelect: process(sel, in0, in1)
  begin
    if sel = '1' then
        muxOut <= in1 after delay;
    elsif sel = '0' then
        muxOut <= in0 after delay;
    else
    	muxOut <= 'X' after delay;
    end if;
  end process muxSelect;

-- muxSelect: process(sel, in0, in1)
--  begin
--   -- case tSelect'(to_X01(sel & in0 & in1)) is
--    case to_X01(tSelect'(sel & in0 & in1)) is
--      -- select in0
--      when "000" => muxOut <= '0' after delay;
--      when "001" => muxOut <= '0' after delay;
--      when "00X" => muxOut <= '0' after delay;
--      when "010" => muxOut <= '1' after delay;
--      when "011" => muxOut <= '1' after delay;
--      when "01X" => muxOut <= '1' after delay;
--      -- select in1
--      when "100" => muxOut <= '0' after delay;
--      when "110" => muxOut <= '0' after delay;
--      when "1X0" => muxOut <= '0' after delay;
--      when "101" => muxOut <= '1' after delay;
--      when "111" => muxOut <= '1' after delay;
--      when "1X1" => muxOut <= '1' after delay;
--      -- select in0 equal to in1
--      when "X00" => muxOut <= '0' after delay;
--      when "X11" => muxOut <= '1' after delay;
--      -- others
--      when others => muxOut <= 'X' after delay;
--    end case;
--  end process muxSelect;


END ARCHITECTURE sim;
