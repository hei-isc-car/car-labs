
ARCHITECTURE rtl OF mux4To1ULogVec IS
BEGIN

  muxSelect: process(sel, in1, in2, in3, in4)
  begin
    case to_integer(unsigned(sel)) is
      when 0 => out1 <= in1 after g_tMux;
      when 1 => out1 <= in2 after g_tMux;
      when 2 => out1 <= in3 after g_tMux;
      when 3 => out1 <= in4 after g_tMux;
      when others => out1 <= (others => 'X') after g_tMux;
    end case;
  end process muxSelect;

END ARCHITECTURE rtl;
