ARCHITECTURE sim OF mux16to1 IS

BEGIN

  P1: process(sel,
              in0, in1, in2, in3,
              in4, in5, in6, in7,
              in8, in9, in10, in11,
              in12, in13, in14, in15
             )
  begin
    case to_integer(sel) is
      when  0 => muxOut <=  in0 after delay;
      when  1 => muxOut <=  in1 after delay;
      when  2 => muxOut <=  in2 after delay;
      when  3 => muxOut <=  in3 after delay;
      when  4 => muxOut <=  in4 after delay;
      when  5 => muxOut <=  in5 after delay;
      when  6 => muxOut <=  in6 after delay;
      when  7 => muxOut <=  in7 after delay;
      when  8 => muxOut <=  in8 after delay;
      when  9 => muxOut <=  in9 after delay;
      when 10 => muxOut <= in10 after delay;
      when 11 => muxOut <= in11 after delay;
      when 12 => muxOut <= in12 after delay;
      when 13 => muxOut <= in13 after delay;
      when 14 => muxOut <= in14 after delay;
      when 15 => muxOut <= in15 after delay;
      when others => null;
    end case;
  end process P1;

END ARCHITECTURE sim;
