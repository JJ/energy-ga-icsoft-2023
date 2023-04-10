package Utils;
use Exporter 'import';

our @EXPORT_OK = qw( %command_lines );

our %command_lines = ( deno => "/home/jmerelo/.deno/bin/deno run scripts/sets.deno.js",
                     bun => "/home/jmerelo/.bun/bin/bun run scripts/sets.node.js",
                     node => "/home/jmerelo/.nvm/versions/v18.0.0/bin/node scripts/sets.node.js" );

