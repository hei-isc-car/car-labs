ARCHITECTURE sim OF shiftRightSigned IS
BEGIN
  shOut <= shift_right(shIn, shiftBitNb) after delay;
END ARCHITECTURE sim;
