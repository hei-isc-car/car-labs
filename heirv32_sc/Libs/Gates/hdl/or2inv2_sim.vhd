ARCHITECTURE sim OF or2inv2 IS
BEGIN
  out1 <= (not in1) or (not in2) after delay;
END ARCHITECTURE sim;
