ARCHITECTURE sim OF resizeSigned IS
BEGIN
  resOut <= resize(resIn, resOut'length) after delay;
END ARCHITECTURE sim;
