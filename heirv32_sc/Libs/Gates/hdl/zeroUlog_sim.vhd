/*
  zeroUlog_sim.vhd

  Generate an std_ulogic_vector of '0's.

  Interface:
    -- Output
    zero : out std_ulogic_vector(dataBitNb-1 downto 0); -- Output value

    -- Generics
    dataBitNb : positive := 8;                          -- Number of bits of the output

  Changelog:
    14.01.2025 - AMA - First version
*/
ARCHITECTURE sim OF zeroUlog IS
BEGIN

  -- Generate '0's
  zero <= (others => '0');

END ARCHITECTURE sim;
