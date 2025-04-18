#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(lib ../lib ../../lib);
use Utils qw(%command_lines process_pinpoint_output);

my $script = shift || "sets";
my $ITERATIONS = 15;
my ($mon,$day,$hh,$mm,$ss) = localtime() =~ /(\w+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)/;
my $suffix = "$day-$mon-$hh-$mm-$ss";

open my $fh, ">", "../../data/pinpoint-v3-$script-$suffix.csv";
say $fh "Tool,VM,size,GPU,PKG,seconds";

my $infix = "node";
for my $l ( qw(512 1024 2048) ) {
  my $total_seconds;
  my $successful = 0;
  my @results;
  do {
    my $command = $command_lines{"bun"}.$script.".".$infix.".js ". $l;
    say $command;
    my ( $gpu, $pkg, $seconds ) = `pinpoint $command 2>&1`;
    my @results = process_pinpoint_output $output;
    if ($gpu != 0 ) {
      $successful++;
      $total_seconds += $seconds;
      say "pinpoint, $l, $gpu ,$pkg";
      push @results, [$gpu, $pkg,$seconds];
    }
  } while ( $successful < $ITERATIONS );

  foreach  my $row (@results) {
    say join(", ", @$row);
    say $fh "pinpoint, bun, $l, ", join(", ", @$row);
  }
}
close $fh;
