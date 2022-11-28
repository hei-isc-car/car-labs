FILE_NAMING_RULE: %(entity_name)_%(arch_name)_config.vhd
DESCRIPTION_START
This is the default template used for the creation of VHDL Configuration files.
Template supplied by Mentor Graphics.
DESCRIPTION_END
--
-- VHDL Configuration %(library).%(unit).%(view)
--
-- Created:
--          by - %(user).%(group) (%(host))
--          at - %(time) %(date)
--
-- using Mentor Graphics HDL Designer(TM) %(version)
--
CONFIGURATION %(entity_name)_config OF %(entity_name) IS
   FOR %(arch_name)
   END FOR;
END %(entity_name)_config;

