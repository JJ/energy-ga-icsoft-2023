#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(lib ../lib);
use Utils qw(%command_lines);

my $script = shift || "sets";
my $ITERATIONS = 15;
my ($mon,$day,$hh,$mm,$ss) = localtime() =~ /(\w+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)/;
my $suffix = "$day-$mon-$hh-$mm-$ss";

open my $fh, ">", "data/pinpoint-intel-vms-$script-$suffix.csv";
say $fh "Tool,VM,size,cores,RAM,seconds";

my $pinpoint_cli = "/home/jmerelo/bin/pinpoint -e rapl:cores,rapl:ram";

for my $c ( qw(node bun deno) ) {
  my $infix = $c eq "deno" ? "deno": "node";
  for my $l ( qw(1024 2048 4096) ) {
    my $total_seconds;
    my $successful = 0;
    my @results;
    do {
      my $command = $command_lines{$c}.$script.".".$infix.".js ". $l;
      say $command;
      say "$pinpoint_cli $command 2>&1";
      my $output = `$pinpoint_cli $command 2>&1`;
      if ($output !~ /0.00\s+J/) {
        $successful++;
        my ( $cores, $ram ) = $output =~ /(\d+\.\d+)\s+J/g;
        my ( $seconds ) = $output =~ /(\d+\.\d+) seconds/;
        $total_seconds += $seconds;
        say "pinpoint, $c, $l , $cores, $ram";
        push @results, [$cores, $ram,$seconds];
      }
    } while ( $successful < $ITERATIONS );
    my $average=$total_seconds/ $ITERATIONS;
    my $baseline_output;
    do {
      $baseline_output = `$pinpoint_cli sleep $average 2>&1`;
    } while ($baseline_output =~  /0.00\s+J/);
    my ( $cores, $ram ) = $baseline_output =~ /(\d+\.\d+)\s+J/g;
    say "Baseline $cores $ram";
    foreach  my $row (@results) {
      my @pkg = @$row;
      my $cores_diff = $pkg[0] - $cores;
      my $ram_diff = $pkg[1]- $ram;
      say $fh "pinpoint, $c, $l, ",
        $cores_diff > 0 ?$cores_diff:0,  ", " ,
        $ram_diff > 0?$ram_diff:0,", ",
        $pkg[2];
    }
  }
}
close $fh;
