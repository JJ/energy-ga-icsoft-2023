use strict;
use warnings;
use Test::More;

use_ok('Utils');

# Test process_powermatrics_output
my $result = process_powermatrics_output($input), $expected_output, "process_powermatrics_output correctly converts input string to array of arrays");

done_testing();