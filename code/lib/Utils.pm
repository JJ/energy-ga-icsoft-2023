package Utils;
use Exporter 'import';

use Time::Piece;

use feature qw(say);

our @EXPORT_OK = qw( %command_lines process_powermetrics_output);

our %command_lines = ( deno => "/home/jmerelo/.deno/bin/deno run scripts/",
                     bun => "/home/jmerelo/.bun/bin/bun run scripts/",
                     node => "/home/jmerelo/.nvm/versions/node/v18.16.0/bin/node scripts/" );

sub process_powermetrics_output {
  my $output_file_name = shift;
  my $content = do {
    local $/ = undef;
    open my $fh, "<", $output_file_name;
    <$fh>;
  };

  my @samples = split /\s+\*\*\* Sampled system activity/, $content;
  my @times = map { /^\s+\((.+?)\)/ } @samples;
  say convert_to_date($times[-1]);
  say convert_to_date($times[0]);
  my $duration = convert_to_date($times[-1]) - convert_to_date($times[0]);
  say $duration;

}

sub convert_to_date {
  my $date_string = shift;
  my $no_weekday = substr $date_string, 4;
  return Time::Piece->strptime( $no_weekday,'%b %d %H:%M:%S %Y %z');
}