ARCHITECTURE sim OF shiftLeftSigned IS
BEGIN
  shOut <= shift_left(shIn, shiftBitNb) after delay;
END ARCHITECTURE sim;
