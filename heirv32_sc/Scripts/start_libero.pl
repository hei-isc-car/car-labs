#!/usr/bin/perl
# filename:          start_libero.pl
# created by:        Corthay Francois & Zahno Silvan
#
#-------------------------------------------------------------------------------
#
# Description:
#   Starts Libero in the correct timezone for the Synplify License
#   Help Parameter : <?>
#   Parameter : start_libero.pl <Libero File Spec>
#-------------------------------------------------------------------------------
#
# History:
#   V0.1 : zas 08.2019 -- Initial release
#
################################################################################

$separator = '-' x 79;
$indent = ' ' x 2;
$verbose = 1;

$ENV{TZ} = ''; # needed to be able to run Synplify avoinding license error
my $designerExe = "$ENV{LIBERO_HOME}\\Designer\\bin\\libero.exe";
$liberoFileSpec = $ARGV[0];

#-------------------------------------------------------------------------------
# Launch Libero
#

if ($verbose == 1) {
  print "\n";
  print "launching $designerExe\n";
  print $indent, "project file spec: $liberoFileSpec\n";
  print "$separator\n";
}

system("$designerExe $liberoFileSpec");