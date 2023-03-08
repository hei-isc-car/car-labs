FILE_NAMING_RULE: %(entity_name)_pkg_body.vhd
DESCRIPTION_START
This is the default template used for the creation of VHDL Package Body files.
Template supplied by Mentor Graphics.
DESCRIPTION_END
--
-- VHDL Package Body %(library).%(unit)
--
-- Created:
--          by - %(user).%(group) (%(host))
--          at - %(time) %(date)
--
-- using Mentor Graphics HDL Designer(TM) %(version)
--
PACKAGE BODY %(entity_name) IS
END %(entity_name);
