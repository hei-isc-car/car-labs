ARCHITECTURE sim OF and3inv3 IS
BEGIN
  out1 <= (not in1) and (not in2) and (not in3) after delay;
END ARCHITECTURE sim;
