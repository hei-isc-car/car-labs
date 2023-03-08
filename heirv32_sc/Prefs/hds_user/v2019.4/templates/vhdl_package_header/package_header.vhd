FILE_NAMING_RULE: %(entity_name)_pkg.vhd
DESCRIPTION_START
This is the default template used for the creation of VHDL Package Header files.
Template supplied by Mentor Graphics.
DESCRIPTION_END
--
-- VHDL Package Header %(library).%(unit)
--
-- Created:
--          by - %(user).%(group) (%(host))
--          at - %(time) %(date)
--
-- using Mentor Graphics HDL Designer(TM) %(version)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
PACKAGE %(entity_name) IS
END %(entity_name);
