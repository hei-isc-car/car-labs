ARCHITECTURE sim OF resizeUnsigned IS
BEGIN
  resOut <= resize(resIn, resOut'length) after delay;
END ARCHITECTURE sim;
