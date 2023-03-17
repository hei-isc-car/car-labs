#!/usr/bin/perl
# filename:          update_diamond.pl
# created by:        Corthay Francois & Zahno Silvan & Amand Axel
#
#-------------------------------------------------------------------------------
#
# Description:
#   Updates the file references in the .ldf Lattice project file
#   and launches the Diamond project manager
#   Help Parameter : <?>
#   Parameter : update_diamond.pl <Diamond File Spec> <VHDL File Spec> <LPF File Spec>
#-------------------------------------------------------------------------------
#
# History:
#   V0.1 : cof 12.2013 -- Initial release
#   V0.2 : zas 08.2019 -- Changed actel to libero
#   V0.3 : ama 02.2023 -- Adapted for diamond
#
################################################################################

$separator = '-' x 79;
$indent = ' ' x 2;
$verbose = 1;
$| = 1; # forces flush on prints

$ENV{TZ} = ''; # needed to be able to run Synplify avoinding license error
my $designerExe = "$ENV{DIAMOND_HOME}\\bin\\nt64\\pnmain.exe";
$diamondFileSpec = $ARGV[0];
$vhdlFileSpec = $ARGV[1];
$lpfFileSpec = $ARGV[2];

use File::Basename;
$diamond_dir  = dirname(dirname($vhdlFileSpec)) . '/diamond/'; # get up concat and into diamond
$projectTitle = basename($diamondFileSpec, ".ldf");


if ($verbose == 1) {
  print "Script Parameters:\n";
  print "  * diamondFileSpec: $diamondFileSpec\n";
  print "  * vhdlFileSpec: $vhdlFileSpec\n";
  print "  * lpfFileSpec: $lpfFileSpec\n";
  print "  * Project title: $projectTitle\n"
}


#-------------------------------------------------------------------------------
# Project variables
#

$diamondWorkFileSpec = $diamondFileSpec . '.tmp';
															  # source directory
my $sourceDir = "$ENV{CONCAT_DIR}";
my $projectDir = "$ENV{DIAMOND_WORK_DIR}";

#-------------------------------------------------------------------------------
# Update paths in the project file
#

if ($verbose == 1) {
  print "\n$separator\n\n";
  print "Updating file specifications in $diamondFileSpec\n";
  print $indent, "temporary file spec: $diamondWorkFileSpec\n";
}
my $line;
if ( !open(DiamondFile, $diamondFileSpec) ){
  print("\nCould not open $diamondFileSpec !\nExiting (failure)\n\n");
  die "\nCould not open $diamondFileSpec !\nExiting (failure)\n\n";
}

open(workFile, ">$diamondWorkFileSpec");
while (chop($line = <DiamondFile>)) {

                                                        # replace title
  if ($line =~ m/<BaliProject.*title=".*"/i) {
    if ($verbose == 1) {print " * Replacing title line\n";}
    $line =~ s/title=".*?"/title="$projectTitle"/;
  }
                                                        # replace VHDL file spec
  if ($line =~ m/<Source\sname=".*\.vhd"/i) {
    if ($verbose == 1) {print " * Replacing VHDL line\n";}
    $line =~ s/".*\.vhd"/"$vhdlFileSpec"/;
  }
                                                         # replace LPF file spec
  if ($line =~ m/<Source\sname=".*\.lpf"/i) {
    if ($verbose == 1) {print " * Replacing LPF line\n";}
    $line =~ s/".*\.lpf"/"$lpfFileSpec"/;
  }
                                                         # replace RVA file spec
  if ($line =~ m/<Source\sname="(.*\.rva)"/i) {
    if ($verbose == 1) {print " * Replacing RVA line\n";}
    $tpath = $diamond_dir . basename($1);
    $line =~ s/".*\.rva"/"$tpath"/;
  }
                                                         # replace RVL file spec
  if ($line =~ m/<Source\sname="(.*\.rvl)"/i) {
    if ($verbose == 1) {print " * Replacing RVL line\n";}
    $tpath = $diamond_dir . basename($1);
    $line =~ s/".*\.rvl"/"$tpath"/;
  }
                                                         # replace XCF file spec
  if ($line =~ m/<Source\sname="(.*\.xcf)"/i) {
    if ($verbose == 1) {print " * Replacing XCF line\n";}
    $tpath = $diamond_dir . basename($1);
    $line =~ s/".*\.xcf"/"$tpath"/;
  }
                                                         # replace strategy
  if ($line =~ m/<Strategy\sfile="(.*\.sty)"/i) {
    if ($verbose == 1) {print " * Replacing Strategy line\n";}
    $tpath = $diamond_dir . basename($1);
    $line =~ s/".*\.sty"/"$tpath"/;
  }

  print workFile ("$line\n");
}

close(workFile);
close(DiamondFile);


#-------------------------------------------------------------------------------
# delete original file and rename temporary file
#
unlink($diamondFileSpec);
rename($diamondWorkFileSpec, $diamondFileSpec);

if ($verbose == 1) {
  print "\nDone\n\n";
  print "$separator\n\n";
}
