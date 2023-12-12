#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(lib ../lib ../../lib);
use Utils qw(%command_lines);

my $script = shift || "chromosome_generation";
my $ITERATIONS = 15;
my ($mon,$day,$hh,$mm,$ss) = localtime() =~ /(\w+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)/;
my $suffix = "$day-$mon-$hh-$mm-$ss";

open my $fh, ">", "../../../data/pinpoint-v2-$script-$suffix.csv";
say $fh "Tool,VM,size,GPU,PKG,seconds";

my $infix = "node";
my $bun_cli = "/home/jmerelo/.bun/bin/bun";
for my $l ( qw(512 1024 2048 ) ) {
  my $total_seconds;
  my $successful = 0;
  my @results;
  do {
    my $command = "$bun_cli run chromosome_creation.node.js $l";
    say $command;
    my $output = `pinpoint $command 2>&1`;
    if ($output !~ /0.00\s+J/) {
      $successful++;
      my ( $gpu, $pkg ) = $output =~ /(\d+\.\d+)\s+J/g;
      my ( $seconds ) = $output =~ /(\d+\.\d+) seconds/;
      $total_seconds += $seconds;
      say "pinpoint, $l , $gpu ,$pkg";
      push @results, [$gpu, $pkg, $seconds];
    }
  } while ( $successful < $ITERATIONS );

  foreach  my $row (@results) {
    say join(", ", @$row);
    say $fh "pinpoint, bun, $l, ", join(", ", @$row);
  }
}
close $fh;
