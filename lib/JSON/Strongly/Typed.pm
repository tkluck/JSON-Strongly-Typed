package JSON::Strongly::Typed;

use 5.018;
use strict;
use warnings;
use Carp;

our $VERSION = '0.01';

require Exporter;
our @ISA = qw(Exporter);

use Types::Standard qw( :all );
our @EXPORT_OK= qw(serialize_json ArrayRef HashRef Int Str Num);
use JSON;

# For now, we use the existing JSON module for encoding the non-reference
# scalar values, so we don't have to worry about floating point, string
# quoting/escaping and unicode.
my $JSON= JSON->new->allow_nonref;


sub serialize_json {
    my ($data, $type, @superfluous_args)= @_;
    die "Too many arguments for serialize_json" if @superfluous_args;

    my $json= "";
    _recurse($json, $data, $type);

    return $json;
}

sub _recurse {
    my ($build_json, $data, $type)= @_;

    if(!ref $data) {
        if($type eq Str) {
            $_[0].= $JSON->encode("$data");
            return;
        } elsif($type eq Int) {
            $_[0].= $JSON->encode(int(0 + $data));
            return;
        } elsif($type eq Num) {
            $_[0].= $JSON->encode(0 + $data);
            return;
        } else {
            die "Data incompatible with type specification: <$data> is not a reference, but type is <$type>";
        }
    } elsif(ref $data eq 'ARRAY') {
        if(ArrayRef->is_supertype_of($type)) {
            $_[0].= "[";
            my $first=1;
            for my $element (@$data) {
                $_[0].= "," unless $first;
                _recurse($_[0], $element, $type->parameters->[0]);
                $first= 0;
            }
            $_[0].= "]";
        } else {
            die "Data incompatible with type specification: encountered array reference where <$type> expected";
        }
    } elsif(ref $data eq 'HASH') {
        if(HashRef->is_supertype_of($type)) {
            $_[0].= "{";
            my $first=1;
            for my $key (sort keys %$data) {
                my $value= $data->{$key};
                $_[0].= "," unless $first;

                _recurse($_[0], $key, Str);
                $_[0].=":";
                _recurse($_[0], $value, $type->parameters->[0]);
                $first= 0;
            }
            $_[0].= "}";
        } else {
            die "Data incompatible with type specification: encountered array reference where <$type> expected";
        }
    } elsif($data->can('TO_JSON')) {
        _recurse($_[0], $data->TO_JSON, $type);
    } else {
        die "Data of type <@{[ ref $data ]}> not supported yet";
    }
}


1;
__END__
=head1 NAME

JSON::Strongly::Typed - Perl module for encoding JSON without relying on
internal flags for strong typing.

=head1 SYNOPSIS

  use JSON::Strongly::Typed qw( serialize_json );
  print serialize_json([qw(1 2 3 4)], ArrayRef[Int])
  [1,2,3,4]


=head1 DESCRIPTION

This module allows you to encode your data structures as JSON while specifying
the data type (most importantly, the distinction between a JSON number an a
JSON string) explicitly.

The commonly used C<< JSON >> module makes this distinction implicitly: whether a variable
is output as a string or as a number may depend on how it has been used previously.
Most famously, this results in things like:

    use JSON qw( encode_json );
    my $a= 3;
    print "The value of a is: $a\n" if DEBUG;
    print encode_json([$a])

resulting in [3] if DEBUG is false, and ["3"] if it is true.

With this module, this is replaced by

    use JSON::Strongly::Typed qw( serialize_json ArrayRef Int );
    my $a= 3;
    print "The value of a is: $a\n" if DEBUG;
    print serialize_json([$a], ArrayRef[Int])


=head1 EXPORT

Nothing is exported implicitly. You can choose to explicitly import the single
function C<< serialize_json >>. In addition, for your convenience, a few useful
exports from Types::Standard are also available as imports from this module:
C<< HashRef >>, C<< ArrayRef >> , C<< Int >>, C<< Str >>, and C<< Num >>.

=head1 SEE ALSO

This module addresses the same concern as C<< JSON::Types >>, but it is hoped that it
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
