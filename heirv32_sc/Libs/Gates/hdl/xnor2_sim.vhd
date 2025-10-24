ARCHITECTURE sim OF xnor2 IS
BEGIN
  xorOut <= not in1 xor in2 after delay;
END ARCHITECTURE sim;
