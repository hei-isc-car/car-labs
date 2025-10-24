ARCHITECTURE sim OF nand2 IS
BEGIN
  out1 <= not( in1 and in2 ) after delay;
END ARCHITECTURE sim;
