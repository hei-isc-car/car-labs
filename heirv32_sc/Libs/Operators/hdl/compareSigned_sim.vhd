ARCHITECTURE sim OF compareSigned IS
BEGIN

  gt <= '1' after delay when a > b
    else '0' after delay;

  ge <= '1' after delay when a >= b
    else '0' after delay;

  eq <= '1' after delay when a = b
    else '0' after delay;

  le <= '1' after delay when a <= b
    else '0' after delay;

  lt <= '1' after delay when a < b
    else '0' after delay;

END ARCHITECTURE sim;
