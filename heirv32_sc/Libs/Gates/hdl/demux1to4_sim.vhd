ARCHITECTURE sim OF demux1to4 IS
BEGIN

  process(sel, in1)
  begin
    -- default values
    out0 <= '0';
    out1 <= '0';
    out2 <= '0';
    out3 <= '0';

    -- selection
    case sel is
      when "00" => out0 <= in1 after delay;
      when "01" => out1 <= in1 after delay;
      when "10" => out2 <= in1 after delay;
      when "11" => out3 <= in1 after delay;
      when others => NULL;
    end case;

  end process;

END ARCHITECTURE sim;
