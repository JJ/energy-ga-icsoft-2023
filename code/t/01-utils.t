use strict; # -*- mode:cperl -*-
use warnings;
use Test::More;

use feature qw(say);

use lib qw(lib ../lib);
use Utils qw( mini_slurp process_powermetrics_output process_pinpoint_output);

my $input_file_name = "../data-raw/output.txt";

my @result = process_powermetrics_output( $input_file_name);
say join(" ", @result);
ok(@result, "Got a result");

$input_file_name = "../data-raw/output-pinpoint.txt";
my $output = mini_slurp $input_file_name;

@result = process_pinpoint_output( $output );
say @result;

for my $r (@result) {
  say $r;
  like( $r, qr/\d+\.\d+/, "$r looks like a floating point number" );
}

$output = mini_slurp "../data-raw/output-pinpoint-failed.txt";
@result = process_pinpoint_output( $output );

for my $r (@result) {
  is( $r, 0 );
}

done_testing();
