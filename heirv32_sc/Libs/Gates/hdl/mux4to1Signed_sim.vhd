ARCHITECTURE sim OF mux4to1Signed IS

BEGIN

  muxSelect: process(sel, in0, in1, in2, in3)
  begin
    case to_integer(sel) is
      when 0 => muxOut <= in0 after delay;
      when 1 => muxOut <= in1 after delay;
      when 2 => muxOut <= in2 after delay;
      when 3 => muxOut <= in3 after delay;
      when others => muxOut <= (others => 'X') after delay;
    end case;
  end process muxSelect;

END ARCHITECTURE sim;
