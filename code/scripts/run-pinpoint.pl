#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(lib ../lib ../../lib);
use Utils qw(%command_lines);

my $script = shift || "sets";
my $ITERATIONS = 15;
my ($mon,$day,$hh,$mm,$ss) = localtime() =~ /(\w+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)/;
my $suffix = "$day-$mon-$hh-$mm-$ss";

open my $fh, ">", "data/pinpoint-v2-$script-$suffix.csv";
say $fh "Tool,VM,size,GPU,PKG,seconds";

for my $c ( qw(node bun deno) ) {
  my $infix = $c eq "deno" ? "deno": "node";
  for my $l ( qw(1024 2048 4096) ) {
    my $total_seconds;
    my $successful = 0;
    my @results;
    do {
      my $command = $command_lines{$c}.$script.".".$infix.".js ". $l;
      say $command;
      my $output = `pinpoint $command 2>&1`;
      if ($output !~ /0.00\s+J/) {
        $successful++;
        my ( $gpu, $pkg ) = $output =~ /(\d+\.\d+)\s+J/g;
        my ( $seconds ) = $output =~ /(\d+\.\d+) seconds/;
        $total_seconds += $seconds;
        say "pinpoint, $c, $l , $gpu ,$pkg";
        push @results, [$gpu, $pkg,$seconds];
      }
    } while ( $successful < $ITERATIONS );

    foreach  my $row (@results) {
      say join(", ", @$row);
      say $fh "pinpoint, bun, $l, ", join(", ", @$row);
    }
  }
}
close $fh;
