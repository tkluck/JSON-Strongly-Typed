use 5.018;
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME              => 'JSON::Strongly::Typed',
    VERSION_FROM      => 'lib/JSON/Strongly/Typed.pm',
    PREREQ_PM         => {
        'JSON'      => '2.19',
        'Type::Tiny' => 1.000005,
    },
    ABSTRACT_FROM     => 'lib/JSON/Strongly/Typed.pm',
    AUTHOR            => 'Timo Kluck <tkluck@infty.nl>',
    LICENSE           => 'perl',
);
