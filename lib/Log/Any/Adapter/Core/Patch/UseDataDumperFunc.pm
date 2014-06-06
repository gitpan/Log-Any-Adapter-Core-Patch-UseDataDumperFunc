package Log::Any::Adapter::Core::Patch::UseDataDumperFunc;

use 5.010001;
use strict;
no warnings;
use Log::Any; # required prior to loading Log::Any::Adapter::Core

use Module::Patch 0.12 qw();
use base qw(Module::Patch);

use Data::Dumper qw(Dumper);

our $VERSION = '0.01'; # VERSION
our $DATE = '2014-06-06'; # DATE

our %config;

my $_dump_one_line = sub {
    my ($value) = @_;

    return Dumper($value);
};

sub patch_data {
    return {
        v => 3,
        patches => [
            {
                action      => 'replace',
                mod_version => qr/^0\.\d+$/,
                sub_name    => '_dump_one_line',
                code        => $_dump_one_line,
            },
        ],
    };
}

1;
# ABSTRACT: Use Data::Dumper function to dump data structures

__END__

=pod

=encoding UTF-8

=head1 NAME

Log::Any::Adapter::Core::Patch::UseDataDumperFunc - Use Data::Dumper function to dump data structures

=head1 VERSION

This document describes version 0.01 of Log::Any::Adapter::Core::Patch::UseDataDumperFunc (from Perl distribution Log-Any-Adapter-Core-Patch-UseDataDumperFunc), released on 2014-06-06.

=head1 SYNOPSIS

 use Log::Any '$log';
 use Log::Any::DDF; # shortcut for Log::Any::Adapter::Core::Patch::UseDataDumperFunc;

 $log->debug("See this data structure: %s", $some_data);

=head1 DESCRIPTION

Log::Any dumps data structures using L<Data::Dumper> like this:

 sub _dump_one_line {
     my ($value) = @_;

     return Data::Dumper->new( [$value] )->Indent(0)->Sortkeys(1)->Quotekeys(0)
       ->Terse(1)->Dump();
 }

This patch replaces that subroutine with:

 sub _dump_one_line {
     my ($value) = @_;

     return Dumper($value);
 }

The goal is to be able to customize the dumping parameter by setting the various
C<$Data::Dumper::*> variables (e.g. C<Indent>, C<Terse>, etc).

=for Pod::Coverage ^(patch_data)$

=head1 FAQ

=head1 SEE ALSO

L<Log::Any::Adapter::Core::Patch::SetDumperIndent>

L<Log::Any::Adapter::Core::Patch::UseDataDump>

L<Log::Any::Adapter::Core::Patch::UseDataDumperPerlTidy>

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Log-Any-Adapter-Core-Patch-UseDataDumperFunc>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Log-Any-Adapter-Core-Patch-UseDataDumperFunc>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Log-Any-Adapter-Core-Patch-UseDataDumperFunc>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
