JSON-Strongly-Typed version 0.01
================================

This module allows you to encode your data structures as JSON while specifying
the data type (most importantly, the distinction between a JSON number an a
JSON string) explicitly.

The commonly used JSON module makes this distinction implicitly: whether a variable
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

INSTALLATION

To install this module type the following:

   perl Makefile.PL
   make
   make test
   make install

DEPENDENCIES

This module requires these other modules and libraries:

  JSON
  Type::Tiny

COPYRIGHT AND LICENCE

Copyright (C) 2016 by Timo Kluck

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.22.1 or,
at your option, any later version of Perl 5 you may have available.
