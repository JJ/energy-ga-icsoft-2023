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

open my $fh, ">", "data/powermetrics-mac-vms-$script-$suffix.csv";
say $fh "Tool,VM,size,CPU,seconds";

my $powermetrics_cli = "/usr/bin/powermetrics -i 1000 -o /tmp/output.csv";

for my $c ( qw(node bun deno) ) {
  my $infix = $c eq "deno" ? "deno": "node";
  for my $l ( qw(1024 2048 4096) ) {
    my $total_seconds;
    my $successful = 0;
    my @results;
    for (1..$ITERATIONS) {
      my $command = $command_lines{$c}.$script.".".$infix.".js ". $l;
      my $pid = open(my $h, "$powermetrics_cli 2>&1 |");
      say $pid;
      system($command);
      kill 9, $pid;
      # Read /tmp/output.csv
      open my $fh, "<", "/tmp/output.csv";
      my $output = <$fh>;
      close $fh;

      say $output;
    };
    my $average=$total_seconds/ $ITERATIONS;
    my $baseline_output;
    do {
      $baseline_output = system( "$powermetrics_cli sleep $average 2>&1");
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
