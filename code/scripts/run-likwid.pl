#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(lib ../lib);
use Utils qw(%command_lines);

my $ITERATIONS = 15;
my ($mon,$day,$hh,$mm,$ss) = localtime() =~ /(\w+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)/;
my $suffix = "$day-$mon-$hh-$mm-$ss";
my $tool = "likwid-powermeter";

open my $fh, ">", "data/likwid-sets-$suffix.csv";
say $fh "Tool,size,GPU,PKG,seconds";

for my $l ( qw(1024) ) {
  my $total_seconds;
  my @results;
  my $command = $command_lines{'deno'}." ". $l;
  for (my $i = 0; $i <= $ITERATIONS; $i++ ) {
    my $output = `$tool $command 2>&1`;
    my ( $core, $pkg ) = $output =~ /(\d+\.\d+)\s+Joules/g;
    my ( $seconds ) = $output =~ /(\d+\.\d+) s/;
    $total_seconds += $seconds;
    say "likwid, $l , $core ,$pkg";
    push @results, [$core, $pkg,$seconds];
  }
  
  my $average=$total_seconds/ $ITERATIONS;
  my $baseline_output = `$tool sleep $average 2>&1`;
  my ( $core, $pkg ) = $baseline_output =~ /(\d+\.\d+)\s+Joules/g;
  foreach  my $row (@results) {
    my @core_pkg = @$row;
    my $core_diff = $core_pkg[0] - $core;
    say $fh "pinpoint, $l, ",
      $core_diff > 0 ?$core_diff:0,  ", " ,
      $core_pkg[1]-$pkg,", ",
      $core_pkg[2];
  }
}
close $fh;
