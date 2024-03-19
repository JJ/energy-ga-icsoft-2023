#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(lib ../lib);
use Utils qw(%command_lines_mac);

my $preffix = shift || die "I need a prefix for the data files";
my $command = shift || die "I need a (single) command to run";
my $ITERATIONS = 15;
my ($mon,$day,$hh,$mm,$ss) = localtime() =~ /(\w+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)/;
my $suffix = "$day-$mon-$hh-$mm-$ss";

open my $fh, ">", "data/pinpoint-mac-$script-$suffix.csv";
say $fh "Tool,VM,size,RAM,ECPU,PCPU,seconds";

for my $l ( qw(1024 2048 4096) ) {
    my $total_seconds;
    my $successful = 0;
    my @results;
    do {
      my $cli = "$command $l"
      say $cli;
      my $output = `pinpoint $cli 2>&1`;
      if ($output !~ /0.00\s+J\s+applem:Energy_Counters:PCPU/) {
        $successful++;
        my (@counters) = $output =~ /\s+(\d+\.\d+)\s+J/g;
        my ( $seconds ) = $output =~ /(\d+\.\d+) seconds/;
        $total_seconds += $seconds;
        my $dram = $counters[9];
        my $ecpu = $counters[15];
        my $pcpu = $counters[25];

        say "$preffix, $c, $l , $dram ,$ecpu, $pcpu, $seconds";
        push @results, [$dram, $ecpu, $pcpu, $seconds];
      }
    } while ( $successful < $ITERATIONS );

    foreach  my $row (@results) {
        say join(", ", @$row);
        say $fh "$preffix, $l, ", join(", ", @$row);
    }
}
close $fh;
