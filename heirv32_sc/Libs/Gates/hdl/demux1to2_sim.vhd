ARCHITECTURE sim OF demux1to2 IS
BEGIN

  process(sel, in1)
  begin
    -- default values
    out0 <= '0';
    out1 <= '0';

    -- selection
    case sel is
      when '0' => out0 <= in1 after delay;
      when '1' => out1 <= in1 after delay;
      when others => NULL;
    end case;

  end process;

END ARCHITECTURE sim;
