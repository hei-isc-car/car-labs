ARCHITECTURE sim OF and4inv1 IS
BEGIN
  out1 <= (not in1) and in2 and in3 and in4 after delay;
END ARCHITECTURE sim;
