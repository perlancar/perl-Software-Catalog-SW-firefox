package Software::Catalog::SW::firefox;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Role::Tiny::With;
with 'Software::Catalog::Role::Software';

use Software::Catalog::Util qw(extract_from_url);

sub meta {
    return {
        homepage_url => "https://mozilla.org/firefox",
        versioning_scheme => "Dotted",
    };
}

sub get_latest_version {
    my ($self, %args) = @_;

    extract_from_url(
        url => "https://www.mozilla.org/en-US/firefox/all/",
        re  => qr/ data-latest-firefox="([^"]+)"/,
    );
}

sub canon2native_arch_map {
    return +{
        'linux-x86' => 'linux',
        'linux-x86_64' => 'linux64',
        'win32' => 'win',
        'win64' => 'win64',
    },
}

sub get_download_url {
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

sub get_programs {
    my ($self, %args) = @_;
    [200, "OK", [
        {name=>"firefox", path=>"/"},
    ]];
}

1;
# ABSTRACT: Firefox

=for Pod::Coverage ^(.+)$
