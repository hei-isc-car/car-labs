ARCHITECTURE sim OF nor2_m IS
BEGIN
  out1 <= (not in1) and (not in2) after delay;
END ARCHITECTURE sim;
