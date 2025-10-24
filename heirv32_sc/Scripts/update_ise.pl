#!/usr/bin/perl
# ------------------------------------------------------------------------------
# update_ise
#   replace ucf and vhd filelocation and name in the Xilinx xise project file
#   Help Parameter : <?>
#   Parameter : update_ise.pl <ISE File Spec> <VHDL File Spec> <UCF File Spec>
# ------------------------------------------------------------------------------
# Changelog:
#   2019-06-12 : zas
#     * All parameters given with agruments instead of env variables
#   2015-05-26 : guo
#     * update to environment from HELS v.15.0526
#   2012-05-27 : cof
#     * Initial release
# ------------------------------------------------------------------------------

$separator = '-' x 79;
$indent = ' ' x 2;

$iseFileSpec = $ARGV[0];
$vhdlFileSpec = $ARGV[1];
$ucfFileSpec = $ARGV[2];

$verbose = 1;

if ($verbose == 1) {
  print "Script Parameters:\n";
  print "  * iseFileSpec: $iseFileSpec\n";
  print "  * vhdlFileSpec: $vhdlFileSpec\n";
  print "  * ucfFileSpec: $ucfFileSpec\n";
}


#-------------------------------------------------------------------------------
# program I/O files
#
$tempFileSpec = $iseFileSpec . '.tmp';

if ($verbose == 1) {
  print "\n$separator\n";
  print "Updating file specifications in $iseFileSpec\n";
  print $indent, "temporary file spec: $tempFileSpec\n";
}

#-------------------------------------------------------------------------------
# read original file, edit and save to temporary file
#
my $line;

open(ISEFile, $iseFileSpec) || die "couldn't open $iseFileSpec!";
open(tempFile, ">$tempFileSpec");
while (chop($line = <ISEFile>)) {
                                                            # replace VHDL files
  if ($line =~ m/FILE_VHDL/i) {
    $line =~ s/<file\s+xil_pn\:name=.*?".+?"/<file xil_pn:name="$vhdlFileSpec"/ig;
  }
                                                            # replace EDIF files
  if ($line =~ m/FILE_EDIF/i) {
    $line =~ s/<file\s+xil_pn\:name=.*?".+?"/<file xil_pn:name="$edifFileSpec"/ig;
  }
                                                             # replace UCF files
  if ($line =~ m/FILE_UCF/i) {
    $line =~ s/<file\s+xil_pn\:name=.*?".+?"/<file xil_pn:name="$ucfFileSpec"/ig;
  }
                                                      # Implementation Top files
  if ($line =~ m/\.vhd"/i) {
    $line =~ s/<property\s+xil_pn:name="Implementation\s+Top\s+File"\s+xil_pn\:value=".+?"/<property xil_pn:name="Implementation Top File" xil_pn:value="$vhdlFileSpec"/ig;
  }
  if ($line =~ m/\.edf"/i) {
    $line =~ s/<property\s+xil_pn:name="Implementation\s+Top\s+File"\s+xil_pn\:value=".+?"/<property xil_pn:name="Implementation Top File" xil_pn:value="$edifFileSpec"/ig;
  }
                                                           # replace UCF binding
  if ($line =~ m/\.ucf"/i) {
    $line =~ s/<binding\s+(.+)\s+xil_pn\:name=.*?".+?"/<binding $1 xil_pn:name="$ucfFileSpec"/ig;
  }

  print tempFile ("$line\n");
}

close(tempFile);
close(ISEFile);

#-------------------------------------------------------------------------------
# delete original file and rename temporary file
#
unlink($iseFileSpec);
rename($tempFileSpec, $iseFileSpec);

if ($verbose == 1) {
  print "$separator\n";
}
