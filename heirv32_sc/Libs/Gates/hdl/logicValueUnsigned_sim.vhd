--  logicValueUnsigned_sim.vhd
--
--  Generate a value output as unsigned from given generic g_VALUE on size g_BIT_NB.
--  The output is not checked to fit on given size.
--
--  Interface:
--    -- Output
--    value : out unsigned(g_BIT_NB-1 downto 0); -- Output value
--
--    -- Generics
--    g_VALUE : natural := 0;                      -- Value to output
--    g_BIT_NB : positive := 8;                    -- Number of bits of the output
--
--  Changelog:
--    14.01.2025 - AMA - First version

ARCHITECTURE sim OF logicValueUnsigned IS
BEGIN

  -- Generate the output value
  value <= to_unsigned(g_VALUE, g_BIT_NB);

END ARCHITECTURE sim;
