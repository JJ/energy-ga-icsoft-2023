#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(lib ../lib);
use Utils qw(%command_lines_mac);

my $script = shift || "sets";
my $ITERATIONS = 15;
my ($mon,$day,$hh,$mm,$ss) = localtime() =~ /(\w+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)/;
my $suffix = "$day-$mon-$hh-$mm-$ss";

open my $fh, ">", "data/pinpoint-mac-$script-$suffix.csv";
say $fh "Tool,VM,size,RAM,ECPU,PCPU,seconds";

for my $c ( qw(node bun deno) ) {
  my $infix = $c eq "deno" ? "deno": "node";
  for my $l ( qw(1024 2048 4096) ) {
    my $total_seconds;
    my $successful = 0;
    my @results;
    do {
      my $command = $command_lines_mac{$c}.$script.".".$infix.".js ". $l;
      say $command;
      my $output = `pinpoint $command 2>&1`;
      if ($output !~ /0.00\s+J\s+applem:Energy_Counters:PCPU/) {
        $successful++;
        my (@counters) = $output =~ /\s+(\d+\.\d+)\s+J/g;
        my ( $seconds ) = $output =~ /(\d+\.\d+) seconds/;
        $total_seconds += $seconds;
        my $dram = $counters[9];
        my $ecpu = $counters[15];
        my $pcpu = $counters[25];

        say "pinpoint, $c, $l , $dram ,$ecpu, $pcpu, $seconds";
        push @results, [$dram, $ecpu, $pcpu, $seconds];
      }
    } while ( $successful < $ITERATIONS );
    my $average=$total_seconds/ $ITERATIONS;
    my $baseline_output = `pinpoint sleep $average 2>&1`;
    my ( @counters ) = $baseline_output =~ /(\d+\.\d+)\s+J\s/g;
    my $dram = $counters[9];
    my $ecpu = $counters[15];
    my $pcpu = $counters[25];
    foreach  my $row (@results) {
      my @measures = @$row;
      my $dram_diff = $measures[0] - $dram;
      my $ecpu_diff = $measures[1] - $ecpu;
      my $pcpu_diff = $measures[2] - $pcpu;
      say $fh "pinpoint, $c, $l, ",
        $dram_diff > 0 ?$dram_diff:0,  ", " ,
        $ecpu_diff > 0 ?$ecpu_diff:0,  ", " ,
        $pcpu_diff > 0 ?$pcpu_diff:0,  ", " ,
        $measures[3];
    }
  }
}
close $fh;
