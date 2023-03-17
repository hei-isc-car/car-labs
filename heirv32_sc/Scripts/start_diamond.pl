#!/usr/bin/perl
# filename:          start_diamond.pl
# created by:        Corthay Francois & Zahno Silvan & Amand Axel
#
#-------------------------------------------------------------------------------
#
# Description:
#   Starts Diamond in the correct timezone for the Synplify License
#   Help Parameter : <?>
#   Parameter : start_diamond.pl <Diamond File Spec>
#-------------------------------------------------------------------------------
#
# History:
#   V0.1 : zas 08.2019 -- Initial release
#   V0.2 : ama 02.2023 -- Adapted for Diamond
#
################################################################################

$separator = '-' x 79;
$indent = ' ' x 2;
$verbose = 1;
$| = 1; # forces flush on prints

$ENV{TZ} = ''; # needed to be able to run Synplify avoinding license error
my $designerExe = "$ENV{DIAMOND_HOME}\\bin\\nt64\\pnmain.exe";
$diamondFileSpec = $ARGV[0];

#-------------------------------------------------------------------------------
# Launch Diamond
#

if ($verbose == 1) {
  print "$separator\n\n";
  print "Launching Diamond from $designerExe\n";
  print $indent, "* Project file spec: $diamondFileSpec\n\n";
  print "$separator\n\n";
}

system("$designerExe $diamondFileSpec");
