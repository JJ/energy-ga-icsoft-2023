use strict;
use warnings;
use Test::More;

use lib qw(lib ../lib);
use Utils qw( process_powermetrics_output );

my $FILE_NAME = "data-raw/output.txt";

my $input_file_name = -e $FILE_NAME ? $FILE_NAME : "../data-raw/".$FILE_NAME;
my $result = process_powermetrics_output( $input_file_name);
ok($result, "Got a result");

done_testing();