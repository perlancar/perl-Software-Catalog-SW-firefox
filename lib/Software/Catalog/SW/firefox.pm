package Software::Catalog::SW::firefox;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

use Role::Tiny::With;
with 'Versioning::Scheme::Dotted';
with 'Software::Catalog::Role::Software';

use Software::Catalog::Util qw(extract_from_url);

sub archive_info {
    my ($self, %args) = @_;
    [200, "OK", {
        programs => [
            {name=>"firefox", path=>"/"},
        ],
    }];
}

sub available_versions { [501, "Not implemented"] }

sub canon2native_arch_map {
    return +{
        'linux-x86' => 'linux',
        'linux-x86_64' => 'linux64',
        'win32' => 'win',
        'win64' => 'win64',
    },
}

sub download_url {
    my ($self, %args) = @_;

    # XXX version, language
    [200, "OK",
     join(
         "",
         "https://download.mozilla.org/?product=firefox-latest-ssl&amp;os=", $self->_canon2native_arch($args{arch}),
         "&amp;lang=", "en-US",
     )];

    # XXX if source=1, but we need to retrieve (and preferably cache too) latest
    # version, if version is not specified

    # "https://archive.mozilla.org/pub/firefox/releases/62.0/source/"
}

sub homepage_url { "https://mozilla.org/firefox" }

sub is_dedicated_profile { 1 }

sub latest_version {
    my ($self, %args) = @_;

    extract_from_url(
        url => "https://www.mozilla.org/en-US/firefox/all/",
        re  => qr/ data-latest-firefox="([^"]+)"/,
    );
}

1;
# ABSTRACT: Firefox

=for Pod::Coverage ^(.+)$
