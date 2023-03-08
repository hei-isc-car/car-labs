ARCHITECTURE sim OF mux2to1Signed IS

  signal selInt: std_ulogic;

BEGIN

  selInt <= to_X01(sel);

  muxSelect: process(selInt, in0, in1)
  begin
    if selInt = '0' then
      muxOut <= in0 after delay;
    elsif selInt = '1' then
      muxOut <= in1 after delay;
    elsif in0 = in1 then
      muxOut <= in0 after delay;
    else
      muxOut <= (others => 'X') after delay;
    end if;
  end process muxSelect;

END ARCHITECTURE sim;
