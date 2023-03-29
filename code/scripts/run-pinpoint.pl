#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use lib qw(lib ../lib);
use Utils qw(%command_lines);

my $successful = 0;


for my $l ( qw(1024) ) {
  do {
    my $command = $command_lines{'deno'}." ". $l;
    say $command;
    my $output = `pinpoint $command 2>&1`;
    say $output;
    $successful++;
  } while ( $successful < 15 );
}
