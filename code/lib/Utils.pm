package Utils;
use Exporter 'import';

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

  # split content by lines like these *** Sampled system activity (Wed Oct 25 15:07:36 2023 +0200) (1031.24ms elapsed) ***
    my @samples = split /\s+\*\*\* Sampled system activity/, $content;

}