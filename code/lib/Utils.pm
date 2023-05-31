package Utils;
use Exporter 'import';

our @EXPORT_OK = qw( %command_lines );

our %command_lines = ( deno => "/home/jmerelo/.deno/bin/deno run scripts/",
                     bun => "/home/jmerelo/.bun/bin/bun run scripts/",
                     node => "/home/jmerelo/.nvm/versions/node/v18.16.0/bin/node scripts/" );

