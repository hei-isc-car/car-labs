--  logicValueUlog_sim.vhd
--
--  Generate a value output as std_ulogic_vector from given generic g_VALUE on size g_BIT_NB.
--  The output is not checked to fit on given size.
--  Vector is left filled with '0's like unsigned.
--
--  Interface:
--    -- Output
--    value : out std_ulogic_vector(g_BIT_NB-1 downto 0); -- Output value
--
--    -- Generics
--    g_VALUE : natural := 0;                               -- Value to output
--    g_BIT_NB : positive := 8;                             -- Number of bits of the output
--
--  Changelog:
--    14.01.2025 - AMA - First version

ARCHITECTURE sim OF logicValueUlog IS
BEGIN

  -- Generate the output value
  value <= std_ulogic_vector(to_unsigned(g_VALUE, g_BIT_NB));

END ARCHITECTURE sim;
