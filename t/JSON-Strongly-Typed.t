use strict;
use warnings;

use Test::More tests => 6;
use JSON::Strongly::Typed qw ( serialize_json ArrayRef HashRef Int Str);

is(serialize_json([1,2,3,4], ArrayRef[Int]), "[1,2,3,4]");
is(serialize_json([qw(1 2 3 4)], ArrayRef[Int]), "[1,2,3,4]");
is(serialize_json([1,2,3,4], ArrayRef[Str]), '["1","2","3","4"]');
is(serialize_json([qw(1 2 3 4)], ArrayRef[Str]), '["1","2","3","4"]');

is(serialize_json({a=>3, b=>4}, HashRef[Int]), '{"a":3,"b":4}');
is(serialize_json({a=>3, b=>4}, HashRef[Str]), '{"a":"3","b":"4"}');

