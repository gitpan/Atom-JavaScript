package XML::Atom::Feed::JavaScript;

use strict;
use warnings;
use base qw( XML::Atom::Feed );

our $VERSION = 0.1;

=head1 NAME

XML::Atom::JavaScript - Atom syndication with JavaScript 

=head1 SYNOPSIS

    ## get an Atom feed from the network

    use XML::Atom::API;
    use XML::Atom::JavaScript;

    my $api = XML::Atom::API->new();
    my $feed = $api->getFeed( 'http://example.com/atom.xml' );
    print $feed->asJavascript();

    ## get an atom feed from disk

    use XML::Atom::JavaScript;

    my $feed = XML::Atom::Feed->new( Stream => 'atom.xml' );
    print $feed->asJavascript();

=head1 DESCRIPTION

XML::Atom::Feed::JavaScript exports an additional function into the XML::Atom
package for outputting Atom feeds as javascript. 

=head1 FUNCTIONS 

=head2 asJavascript()

=head1 AUTHORS

=over 4

=item David Jacobs <globaldj@mac.com>

=item Ed Summers <ehs@pobox.com>

=item Brian Cassidy <brian@altnernation.net>

=back

=cut

sub XML::Atom::Feed::asJavascript {
	my ( $feed, $max, $descriptions ) = @_ or die q( can't get feed );

	my $items = scalar $feed->entries;
	if ( not $max or $max > $items ) { $max = $items; }

	## open javascript section
	my $output = _jsPrint( '<div class="atom_feed">' );
	$output   .= _jsPrint( '<div class="atom_feed_title">' . 
	    $feed->title() . '</div>' );

	## open our list
	$output .= _jsPrint( '<ul class="atom_item_list">' );

	## generate content for each item
	foreach my $item ( $feed->entries() ){
		my $link  = $item->link();
		my $title = $item->title();
		my $desc  = $item->content->body();
		my $data  = <<"JAVASCRIPT_TEXT";
<li class="atom_item">
<span class="rss_item_title">
<a class="rss_item_link" href="$link">$title</a>
</span>
JAVASCRIPT_TEXT

		if ( $descriptions or not defined ( $descriptions ) ) { 
		    $data .= " <span class=\"atom_item_desc\">$desc</span>";
		}

		$data .= '</li>';
		$output .= _jsPrint( $data );

	}
	
	## close our item list, and return 
	$output .= _jsPrint( '</ul>' );
	$output .= _jsPrint( '</div>' );
	return $output;

} 


sub _jsPrint { 
    my $string = shift;
    $string =~ s/"/\\"/g;
    $string =~ s/'/\\'/g;
    $string =~ s/\n//g;	
    return( "document.write('$string');\n" );
}
   
1;
