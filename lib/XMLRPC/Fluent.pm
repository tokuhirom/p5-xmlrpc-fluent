package XMLRPC::Fluent;
use Any::Moose;
our $VERSION = '0.01';
use base qw/Exporter/;
our @EXPORT = qw/xmlrpc xmlrpc_type xmlrpc_str/;
use XMLRPC::Lite;
use overload 
    '&{}' => sub {
        my $self = shift;
        sub {
            XMLRPC::Lite->proxy($self->url)->call($self->method, @_)->result;
        }
    },
    fallback => 1,
;

has url => (
    is  => 'ro',
    isa => 'Str',
);

has method => (
    is => 'ro',
    isa => 'Str',
);

sub xmlrpc {
    return XMLRPC::Fluent->new(@_);
}

sub xmlrpc_type { XMLRPC::Data->type(@_) }
sub xmlrpc_str { XMLRPC::Data->type( string => $_[0] ) }

sub BUILDARGS {
    my $class = shift;
    if (@_ == 1 && not ref $_[0]) {
        return {url => $_[0]};
    } else {
        return +{@_};
    }
}

our $AUTOLOAD;
sub AUTOLOAD {
    my $self = shift;
    (my $method = $AUTOLOAD) =~ s/.*:://;
    my $proto = ref $self || $self;
    my $meth = $self->method ? $self->method . '.' . $method : $method;
    return $proto->new(url => $self->url, method => $meth);
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
__END__

=head1 NAME

XMLRPC::Fluent -

=head1 SYNOPSIS

  use XMLRPC::Fluent;

=head1 DESCRIPTION

XMLRPC::Fluent is

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom  slkjfd gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
