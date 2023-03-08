ARCHITECTURE sim OF and4inv3 IS
BEGIN
  out1 <= (not in1) and (not in2) and (not in3) and in4 after delay;
END ARCHITECTURE sim;
