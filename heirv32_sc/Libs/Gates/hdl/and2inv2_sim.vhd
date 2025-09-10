ARCHITECTURE sim OF and2inv2 IS
BEGIN
  out1 <= (not in1) and (not in2) after delay;
END ARCHITECTURE sim;
