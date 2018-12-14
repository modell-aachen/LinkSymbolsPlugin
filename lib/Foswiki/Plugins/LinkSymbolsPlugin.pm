# See bottom of file for default license and copyright information

package Foswiki::Plugins::LinkSymbolsPlugin;

use strict;
use warnings;

use Foswiki::Func    ();    # The plugins API
use Foswiki::Plugins ();    # For the API version

our $VERSION = '0.1';
our $RELEASE = '0.1';

# One line description of the module
our $SHORTDESCRIPTION = 'Symbols are displayed next to file links, indicating their type.';

our $NO_PREFS_IN_TOPIC = 1;

=begin TML

---++ initPlugin($topic, $web, $user) -> $boolean
   * =$topic= - the name of the topic in the current CGI query
   * =$web= - the name of the web in the current CGI query
   * =$user= - the login name of the user
   * =$installWeb= - the name of the web the plugin topic is in
     (usually the same as =$Foswiki::cfg{SystemWebName}=)

=cut

sub initPlugin {
    my ( $topic, $web, $user, $installWeb ) = @_;

    # check for Plugins.pm versions
    if ( $Foswiki::Plugins::VERSION < 2.0 ) {
        Foswiki::Func::writeWarning( 'Version mismatch between ',
            __PACKAGE__, ' and Plugins.pm' );
        return 0;
    }

    my $map = $Foswiki::cfg{LinkSymbolPlugin}{mapping} || '{}';
    my $webmap = $Foswiki::cfg{LinkSymbolPlugin}{webmapping} || '{}';
    my $selector = $Foswiki::cfg{LinkSymbolPlugin}{selector} || 'not(*.*)';
    my $append = $Foswiki::cfg{LinkSymbolPlugin}{append} || '';
    my $prepend = $Foswiki::cfg{LinkSymbolPlugin}{prepend} || '';
    return 1 unless $map && $selector && ($append || $prepend);

    my $linkTarget = Foswiki::Func::getPreferencesValue('PDFLINKTARGET') || '';
    $linkTarget = '_blank' if $linkTarget =~ /blank/i;
    $linkTarget = '_self' unless $linkTarget =~ /^_blank$/;

    Foswiki::Func::addToZone('script', 'LINKSYMBOLS', <<SCRIPT, 'JQUERYPLUGIN::FOSWIKI');
<script type='text/javascript' src='%PUBURLPATH%/%SYSTEMWEB%/LinkSymbolsPlugin/linksymbols.js'></script>
<script type='text/javascript'>foswiki.LinkSymbolsPlugin = { map: $map, webmap: $webmap, selector: '$selector', append: '$append', prepend: '$prepend', pdfLinkTarget: '$linkTarget' };</script>
SCRIPT

    return 1;
}

sub maintenanceHandler {
    Foswiki::Plugins::MaintenancePlugin::registerCheck("LinkSymbolsPlugin:oldConfig", {
        name => "LinkSymbolsPlugin:oldConfig",
        description => "Check if the selector-configuration is at the old standard",
        check => sub {
            if ($Foswiki::cfg{LinkSymbolPlugin}{selector} eq 'div.foswikiTopic a:not(div.patternEditTopic a, div.solrSearchHits a)') {
                return {
                    result => 1,
                    priority => $Foswiki::Plugins::MaintenancePlugin::WARN,
                    solution => "Your configuration for {LinkSymbolPlugin}{selector} is at the old standard. Please hit the 'reset' link in configure."
                };
            }
            return { result => 0 };
        }
    });
}

1;

__END__
Foswiki - The Free and Open Source Wiki, http://foswiki.org/

Copyright (C) 2008-2013 Foswiki Contributors. Foswiki Contributors
are listed in the AUTHORS file in the root of this distribution.
NOTE: Please extend that file, not this notice.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version. For
more details read LICENSE in the root of this distribution.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

As per the GPL, removal of this notice is prohibited.
