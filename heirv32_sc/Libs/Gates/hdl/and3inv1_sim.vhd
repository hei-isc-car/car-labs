ARCHITECTURE sim OF and3inv1 IS
BEGIN
  out1 <= (not in1) and in2 and in3 after delay;
END ARCHITECTURE sim;
