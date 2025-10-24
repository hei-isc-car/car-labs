#!/bin/bash
#===============================================================================
# car-labs.bash
#   Starts HDL designer based on the generic hdlDesigner.bash
#

design_name=`basename $0 .bash`
design_directory=`dirname ${BASH_SOURCE[0]}`

hdl_script_name="$design_directory/Scripts/hdlDesigner.bash"
export HEI_LIBS_DIR="$design_directory/Libs"

verbose=1
SEPARATOR='--------------------------------------------------------------------------------'
INDENT='  '


#-------------------------------------------------------------------------------
# Main script
#
if [ -n "$verbose" ] ; then
  echo "$SEPARATOR"
  echo "Launching HDL-Designer"
  echo "${INDENT}Design name is         $design_name"
  echo "${INDENT}Start directory is     $design_directory"
  echo "${INDENT}HDL designer script is $hdl_script_name"
fi

#-------------------------------------------------------------------------------
# Launch application
#
$hdl_script_name -v -d $design_directory -n $design_name -m hds.hdp
