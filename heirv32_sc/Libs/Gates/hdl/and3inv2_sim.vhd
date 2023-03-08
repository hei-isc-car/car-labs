ARCHITECTURE sim OF and3inv2 IS
BEGIN
  out1 <= (not in1) and (not in2) and in3 after delay;
END ARCHITECTURE sim;
