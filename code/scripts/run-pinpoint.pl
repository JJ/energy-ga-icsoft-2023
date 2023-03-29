#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(lib ../lib);
use Utils qw(%command_lines);

my $ITERATIONS = 15;
my ($mon,$day,$hh,$mm,$ss) = localtime() =~ /(\w+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)/;
my $suffix = "$day-$mon-$hh-$mm-$ss";

open my $fh, ">", "data/pinpoint-sets-$suffix.csv";
say $fh "Tool,size,GPU,PKG,seconds";

for my $l ( qw(1024 2048 4096) ) {
  my $total_seconds;
  my $successful = 0;
  my @results;
  do {
    my $command = $command_lines{'deno'}." ". $l;

    my $output = `pinpoint $command 2>&1`;
    if ($output !~ /0.00\s+J/) {
      $successful++;
      my ( $gpu, $pkg ) = $output =~ /(\d+\.\d+)\s+J/g;
      my ( $seconds ) = $output =~ /(\d+\.\d+) seconds/;
      $total_seconds += $seconds;
      say "pinpoint, $l , $gpu ,$pkg";
      push @results, [$gpu, $pkg,$seconds];
    }
  } while ( $successful < $ITERATIONS );
  my $average=$total_seconds/ $ITERATIONS;
  my $baseline_output;
  do {
    $baseline_output = `pinpoint sleep $average 2>&1`;
  } while ($baseline_output =~  /0.00\s+J/);
  my ( $gpu, $pkg ) = $baseline_output =~ /(\d+\.\d+)\s+J/g;
  foreach  my $row (@results) {
    my @gpu_pkg = @$row;
    my $gpu_diff = $gpu_pkg[0] - $gpu;
    say $fh "pinpoint, $l, ",
      $gpu_diff > 0 ?$gpu_diff:0,  ", " ,
      $gpu_pkg[1]-$pkg,", "
      $gpu_pkg[2];
  }
}
close $fh;
