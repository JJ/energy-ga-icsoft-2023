#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(lib ../lib);
use Utils qw(%command_lines);

my $ITERATIONS = 15;
my ($mon,$day,$hh,$mm,$ss) = localtime() =~ /(\w+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)/;
my $suffix = "$day-$mon-$hh-$mm-$ss";
my $tool = "perf stat -e power/energy-pkg/";

my $prefix = "perfstat";
open my $fh, ">", "data/$prefix-deno-sets-$suffix.csv";

say $fh "Tool,size,PKG,seconds";

for my $l ( qw(1024 2048 4096) ) {
  my $total_seconds;
  my @results;
  my $command = $command_lines{'deno'}." ". $l;
  say $command;
  for (my $i = 0; $i <= $ITERATIONS; $i++ ) {
    my $output = `$tool $command 2>&1`;
    my ( $pkg ) = $output =~ /(\d+,\d+)\s+Joules/g;
    my ( $seconds ) = $output =~ /(\d+,\d+) s/;
    $pkg =~ s/,/./;
    $seconds =~ s/,/./;
    $total_seconds += $seconds;
    say "$prefix, $l , $pkg";
    push @results, [$pkg,$seconds];
  }

  my $average=$total_seconds/ $ITERATIONS;
  my $baseline_output = `$tool sleep $average 2>&1`;
  my ( $pkg ) = $baseline_output =~ /(\d+,\d+)\s+Joules/g;
  $pkg =~ s/,/./;
  foreach  my $row (@results) {
    my @core_pkg = @$row;
    say $fh "$prefix, $l, ",
      $core_pkg[0]-$pkg,", ",
      $core_pkg[1];
  }
}
close $fh;
