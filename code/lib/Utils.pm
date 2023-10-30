package Utils;
use Exporter 'import';
use List::Util qw(reduce);
use Time::Piece;

use feature qw(say);

our @EXPORT_OK = qw( %command_lines process_powermetrics_output);

our %command_lines = ( deno => "/home/jmerelo/.deno/bin/deno run scripts/",
                     bun => "/home/jmerelo/.bun/bin/bun run scripts/",
                     node => "/home/jmerelo/.nvm/versions/v20.9.0/bin/node scripts/" );

sub process_powermetrics_output {
  my $output_file_name = shift;
  my $content = do {
    local $/ = undef;
    open my $fh, "<", $output_file_name;
    <$fh>;
  };

  my @samples = split /\s+\*\*\* Sampled system activity/, $content;
  my @results;
  for my $s (@samples) {
    my ($e_cluster_idle, $p_cluster_idle, $cpu ) = $s =~ /E-Cluster idle \w+\:\s+(\d+\.\d+)%.+P-Cluster idle \w+\:\s+(\d+\.\d+)%.+CPU Power:\s+(\w+)\s+mW/sg;
    push @results, [$e_cluster_idle, $p_cluster_idle, $cpu];
  }
  # Compute average first column
  my $average_e_cluster_idle = ( reduce { $a + $b } map { $_->[0] } @results ) / scalar @results;
  my $average_p_cluster_idle = ( reduce { $a + $b } map { $_->[1] } @results ) / scalar @results;
  my $sum_cpu =  reduce { $a + $b } map { $_->[2] } @results ;
  return ($average_e_cluster_idle, $average_p_cluster_idle, $sum_cpu);
}

sub convert_to_date {
  my $date_string = shift;
  my $no_weekday = substr $date_string, 4;
  return Time::Piece->strptime( $no_weekday,'%b %d %H:%M:%S %Y %z');
}
