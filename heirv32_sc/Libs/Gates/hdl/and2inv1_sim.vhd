ARCHITECTURE sim OF and2inv1 IS
BEGIN
  out1 <= in1 and (not in2) after delay;
END ARCHITECTURE sim;
