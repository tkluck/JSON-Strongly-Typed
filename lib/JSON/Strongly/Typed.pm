package JSON::Strongly::Typed;

use 5.018;
use strict;
use warnings;
use Carp;

require Exporter;

our @ISA = qw(Exporter);


our @EXPORT_OK = ( );


our $VERSION = '0.01';


1;
__END__
=head1 NAME

JSON::Strongly::Typed - Perl module for encoding JSON without relying on
internal flags for strong typing.

=head1 SYNOPSIS

  use JSON::Strongly::Typed;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for JSON::Strongly::Typed, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.

=head1 SEE ALSO

This module addresses the same concern as JSON::Types, but it is hoped that it
gives more flexibility as it doesn't require you to re-build your nested data
structure before encoding it.

=head1 AUTHOR

Timo Kluck, E<lt>tkluck@infty.nlE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by Timo Kluck

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.22.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
