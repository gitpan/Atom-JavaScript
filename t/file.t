use Test::More tests => 2; 

use strict;
use warnings;

use_ok( 'XML::Atom::Feed::JavaScript' );

my $feed = XML::Atom::Feed::JavaScript->new(Stream => 't/atom.xml');
ok( length( $feed->asJavascript() ) > 1000, 'asJavascript()' );

