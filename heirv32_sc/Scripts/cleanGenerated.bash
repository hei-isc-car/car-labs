#!/bin/bash

#================================================================================
# cleanGenerated.bash - Clean intermediate files form folder
#
base_directory="$(dirname "$(readlink -f "$0")")"
pushd $base_directory
base_directory="$base_directory/.."

SEPARATOR='--------------------------------------------------------------------------------'
INDENT='  '

echo "$SEPARATOR"
echo "-- ${0##*/} Started!"
echo ""

#-------------------------------------------------------------------------------
# Remove generated and cache files
#
find $base_directory -type f -name '.cache.dat' | xargs -r rm -v
find $base_directory -type f -name '*.bak' | xargs -r rm -v
find $base_directory -type f -name '*.lck' | xargs -r rm -v
find $base_directory -type f -name '*.vhd.info' | xargs -r rm -v
find $base_directory -type f -name 'default_view' | xargs -r rm -v
find $base_directory -type f -name '*_entity.vhd' | xargs -r rm -v
find $base_directory -type f -name '*_struct.vhd' | xargs -r rm -v
find $base_directory -type f -name '*_fsm.vhd' | xargs -r rm -v
find $base_directory -type f -name '*.vhg' | xargs -r rm -v
find $base_directory -type f -name '*.DS_Store' | xargs -r rm -v
find $base_directory -type d -name '.xrf' | xargs -r rm -Rv

#-------------------------------------------------------------------------------
# Exit
#
echo ""
echo "-- ${0##*/} Finished!"
echo "$SEPARATOR"
popd
