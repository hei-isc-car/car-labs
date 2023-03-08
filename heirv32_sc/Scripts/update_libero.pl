#!/usr/bin/perl
# filename:          update_libero.pl
# created by:        Corthay Francois & Zahno Silvan
#
#-------------------------------------------------------------------------------
#
# Description:
#   Updates the file references in the .prjx Actel project file
#   and launches the Libero project manager
#   Help Parameter : <?>
#   Parameter : update_libero.pl <Libero File Spec> <VHDL File Spec> <^PDC File Spec>
#-------------------------------------------------------------------------------
#
# History:
#   V0.1 : cof 12.2013 -- Initial release
#   V0.2 : zas 08.2019 -- Changed actel to libero
#
################################################################################

$separator = '-' x 79;
$indent = ' ' x 2;
$verbose = 1;

$ENV{TZ} = ''; # needed to be able to run Synplify avoinding license error
my $designerExe = "$ENV{LIBERO_HOME}\\Designer\\bin\\libero.exe";
$liberoFileSpec = $ARGV[0];
$vhdlFileSpec = $ARGV[1];
$pdcFileSpec = $ARGV[2];


if ($verbose == 1) {
  print "Script Parameters:\n";
  print "  * liberoFileSpec: $liberoFileSpec\n";
  print "  * vhdlFileSpec: $vhdlFileSpec\n";
  print "  * pdcFileSpec: $pdcFileSpec\n";
}



#-------------------------------------------------------------------------------
# Project variables
#
$liberoWorkFileSpec = $liberoFileSpec . '.tmp';
															  # source directory
my $sourceDir = "$ENV{CONCAT_DIR}";
my $projectDir = "$ENV{LIBERO_WORK_DIR}";

#-------------------------------------------------------------------------------
# Update paths in the project file
#

if ($verbose == 1) {
  print "\n$separator\n";
  print "Updating file specifications in $liberoFileSpec\n";
  print $indent, "temporary file spec: $liberoWorkFileSpec\n";
}
my $line;

open(LiberoFile, $liberoFileSpec) || die "couldn't open $HDLFileSpec!";
open(workFile, ">$liberoWorkFileSpec");
while (chop($line = <LiberoFile>)) {
                                                           # replace source path
  if ($line =~ m/DEFAULT_IMPORT_LOC/i) {
    $line =~ s/".*"/"$sourceDir"/;
  }
                                                          # replace project path
  if ($line =~ m/ProjectLocation/i) {
    $line =~ s/".*"/"$projectDir"/;
  }
                                                        # replace VHDL file spec
  if ($line =~ m/VALUE\s".*,hdl"/i) {
    $line =~ s/".*"/"$vhdlFileSpec,hdl"/;
  }
                                                         # replace PDC file spec
  if ($line =~ m/VALUE\s".*\.pdc,pdc"/i) {
    $line =~ s/".*"/"$pdcFileSpec,pdc"/;
  }

  print workFile ("$line\n");
}

close(workFile);
close(LiberoFile);


#-------------------------------------------------------------------------------
# delete original file and rename temporary file
#
unlink($liberoFileSpec);
rename($liberoWorkFileSpec, $liberoFileSpec);

if ($verbose == 1) {
  print "$separator\n";
}

#-------------------------------------------------------------------------------
# Launch Libero
#

#if ($verbose == 1) {
#  print "\n";
#  print "launching $designerExe\n";
#  print $indent, "project file spec: $liberoFileSpec\n";
#  print "$separator\n";
#}

#system("$designerExe $liberoFileSpec");
