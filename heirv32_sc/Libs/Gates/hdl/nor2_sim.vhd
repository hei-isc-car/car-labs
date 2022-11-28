ARCHITECTURE sim OF nor2 IS
BEGIN
  out1 <= not( in1 or in2 ) after delay;
END ARCHITECTURE sim;
