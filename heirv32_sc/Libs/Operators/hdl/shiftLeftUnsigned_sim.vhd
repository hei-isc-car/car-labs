ARCHITECTURE sim OF shiftLeftUnsigned IS
BEGIN
  shOut <= shift_left(shIn, shiftBitNb) after delay;
END ARCHITECTURE sim;
