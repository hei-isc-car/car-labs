ARCHITECTURE sim OF or2inv1 IS
BEGIN
  out1 <= (not in1) or in2 after delay;
END ARCHITECTURE sim;
