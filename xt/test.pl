#/usr/bin/perl

use ExtUtils::testlib;

use Text::Markdown 'markdown';
use Text::Markdown::XS;
use Benchmark;
use File::Slurp;
use Text::Diff;

my $text = read_file('xt/index.text');
my $a = Text::Markdown::XS::markdown($text);
my $b = Text::Markdown::markdown($text);

$a =~ s{'}{'\\''}g; # escape ' chars for shell
$b =~ s{'}{'\\''}g;
$a = `echo '$a' | tidy --show-body-only 1 --quiet 1 --show-warnings 0`;
$b = `echo '$b' | tidy --show-body-only 1 --quiet 1 --show-warnings 0`;

unless ( $a eq $b ) {
    print diff \$a, \$b; 
    #die "BOO";
}
my $count = 1000;
timethese($count, {
    'B_Text::Markdown::XS' => sub { Text::Markdown::XS::markdown($text) },
    'A_Text::Markdown' => sub { Text::Markdown::markdown($text) },
});


