#!/usr/bin/perl
# ------------------------------------------------------------------------------
# trimLibs
#   Comment regular libraries in an concatenated file
#   Help Parameter : <?>
#   Parameter : trimlibs.pl <Input File Name> <Output File Name>
# ------------------------------------------------------------------------------
#  Authors:
#    cof: [François Corthay](francois.corthay@hevs.ch)
#    guo: [Oliver A. Gubler](oliver.gubler@hevs.ch)
#    zas: [Silvan Zahno](silvan.zahno@hevs.ch)
#    gal: [Laurent Gauch]
# ------------------------------------------------------------------------------
# Changelog:
#   2019.08.23 : cof
#     * Comment "omment "FOR xxxx : yyy USE ENTITY zzz;"" instead all "For All ... work" lines
#     * Seen problems in ELN_Kart
#   2019.06.11 : zas
#     * Comment "For All .... work."" instead all "For All" lines
#     * Allow Outputfilename as Env var or as Script parameter
#	  2015-08-25 : guo
#	    * added unisim to the list of excluded libraries
#   2015-05-08 : guo
#     * added verbosity debug
#     * changed this header
#     * minor comment modifications
#  2013-08-13 : zas guo
#     Handle error if environment variable not found, character'pos('$') -> ')
#     was found as env var, added exception
#   2013-06-13 : cof zas guo
#     Remove comments from testline
#   2013-01-09 : cof  --
#     * Bugfix: no carriage return on commented "use" statements
#     * Bugfix: more precise targeting of "library" statement
#     * Bugfix: "Library" test after "use" test
#   2012-04-27 : zas
#     * Bugfix: on feature added in version 2011-06-10
#   2012-02-02 : zas
#     * Write the output into a new file with the name defined in the
#     * $DESIGN_NAME variable
#   2012-01-23 : zas
#     * Replaces $env_var_name by the value of the found environmemnt variable.
#     * Mostly used to replace $SIMULATION_DIR for initialise bram's from a file
#     * placed in the Simulation Directory
#   2011-06-10 : zas
#     Replaces
#       library xxx;use xxx.yyy.all;
#     with
#       --library xxx;
#       use work.yyy.all;
#   2005...2011 : cof
#     Improvements
#   2005-01-29 : gal
#	    initlial release
# ------------------------------------------------------------------------------

$separator = '-' x 79;
$indent = ' ' x 2;
$hdlInFileSpec = $ARGV[0];
if (defined $ARGV[1]) {
  $hdlOutFileSpec = $ARGV[1];
}
else {
  $hdlOutFileSpec = 'trimmed.vhd';
}

$verbose = 1;
$debug = 0;

#-------------------------------------------------------------------------------
# program I/O files
#
$tempFileSpec = $hdlOutFileSpec . '.tmp';

if ($verbose == 1) {
  print "\n$separator\n";
  print "Trimming library declarations from $hdlInFileSpec to $hdlOutFileSpec\n";
  print $indent, "temporary file spec: $tempFileSpec\n";
}

#-------------------------------------------------------------------------------
# read original file, edit and save to temporary file
#
my $line;

open(HDLFile, $hdlInFileSpec) || die "couldn't open $HDLFileSpec!";
open(tempFile, ">$tempFileSpec");
while (chop($line = <HDLFile>)) {

  # remove all comment for the test
  my $testline = $line;
  $testline =~ s/--.*//;

  # Replace 'use xxx.yyy' with 'use work.yyy', except if xxx is ieee or std or unisim
  if ($testline =~ m/use\s.*\.all\s*;/i) {
    if ( not($testline =~ m/\bieee\./i) and
		 not($testline =~ m/\bstd\./i)  and
		 not($testline =~ m/\bunisim\./i)) {
      # if there is any char before "use" except \s, insert new line \n
      if ( ($testline =~ m/[^\s]\s*use/i) ) {
        $line =~ s/use\s+.*?\./\nuse work./i;
        if ($debug == 1) {
          print "TEST0099: ", $testline, "\n"
        }
      }
      else {
        $line =~ s/use\s+.*?\./use work./i;
        if ($debug == 1) {
          print "TEST0105: ", $testline, "\n"
        }
      }
    }
  }

  # Comment libraries which aren't ieee or std or unisim
  if (($testline =~ m/\slibrary\s+/i) or ($testline =~ m/\Alibrary\s+/i)) {
    if ( not($testline =~ m/ieee/i) and
		 not($testline =~ m/std/i) and
		 not($testline =~ m/unisim/i)) {
      $line = '-- ' . $line;
    }
  }

  # Comment "FOR xxxx : yyy USE ENTITY zzz;
  if ($line =~ m/for\s+.+:.+\s+use\s+entity/i) {
    $line = '-- ' . $line;
  }

  # Search for $Env_Var_Names and replace them by the value of the env_var
  if ($testline =~ m/(\$[^\s\/.'"\\]+)/i) {
    $envvar = $1;
    $envvar =~ s/^.//;
    eval {
      $line =~ s/\$$envvar/$ENV{$envvar}/;
    };
    if ($@) {
      print ("WARNING: Environment Variable not found: $envvar \n")
    }

  }

  print tempFile ("$line\n");
}

close(tempFile);
close(HDLFile);

#-------------------------------------------------------------------------------
# delete original file and rename temporary file
#
unlink($hdlOutFileSpec);
rename($tempFileSpec, $hdlOutFileSpec);

if ($verbose == 1) {
  print "$separator\n";
}

#if ($verbose == 1) {
#  print $indent, "Hit any <CR> to continue";
#  $dummy = <STDIN>;
#}
