ARCHITECTURE sim OF and4inv4 IS
BEGIN
  out1 <= (not in1) and (not in2) and (not in3) and (not in4) after delay;
END ARCHITECTURE sim;
