use Test::More tests => 5; 
use strict;
use warnings;
use XML::Atom::API;

use_ok( 'XML::Atom::Feed::JavaScript' );

my $api = XML::Atom::API->new();
isa_ok( $api, 'XML::Atom::API' );

my $feed = $api->getFeed( 
    'http://diveintomark.org/tests/client/http/200.xml' 
);
isa_ok( $feed, 'XML::Atom::Feed' );

is( $feed->title(), "Feed 200", 'title() works ok' );
ok( $feed->asJavascript(), 'asJavaScript()' );

