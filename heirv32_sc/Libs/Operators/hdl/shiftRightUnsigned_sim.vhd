ARCHITECTURE sim OF shiftRightUnsigned IS
BEGIN
  shOut <= shift_right(shIn, shiftBitNb) after delay;
END ARCHITECTURE sim;
