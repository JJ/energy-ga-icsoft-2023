package Utils;
use Exporter 'import';

our @EXPORT_OK = qw( %command_lines );

our %command_lines = ( deno => "/home/jmerelo/.deno/bin/deno run scripts/sets.deno.js",
                     bun => "bun run scripts/sets.node.js",
                     node => "node scripts/sets.node.js" );

