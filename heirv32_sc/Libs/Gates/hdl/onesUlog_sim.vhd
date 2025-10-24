/*
  onesUlog_sim.vhd

  Generate an std_ulogic_vector of '1's.

  Interface:
    -- Output
    ones : out std_ulogic_vector(dataBitNb-1 downto 0); -- Output value

    -- Generics
    dataBitNb : positive := 8;                          -- Number of bits of the output

  Changelog:
    14.01.2025 - AMA - First version
*/
ARCHITECTURE sim OF onesUlog IS
BEGIN

  -- Generate '1's
  ones <= (others => '1');

END ARCHITECTURE sim;
