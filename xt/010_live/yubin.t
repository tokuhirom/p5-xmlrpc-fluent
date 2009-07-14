use strict;
use warnings;
use Test::More tests => 4;
use XMLRPC::Fluent;
use Data::Dumper;

my $rpc = xmlrpc('http://yubin.senmon.net/service/xmlrpc/');
isa_ok $rpc, 'XMLRPC::Fluent';
isa_ok $rpc->yubin, 'XMLRPC::Fluent';
like $rpc->yubin->getVersion->(), qr/^\d\.\d+[a-z]?$/;

my $r = $rpc->yubin->fetchAddressByPostcode->(xmlrpc_str('0802336'));
is_deeply $r,
  [
    {
        'jiscode'        => '01207',
        'pref'           => "\x{5317}\x{6d77}\x{9053}",
        'town_kana'      => "\x{3084}\x{3061}\x{3088}\x{3061}\x{3087}\x{3046}",
        'town'           => "\x{516b}\x{5343}\x{4ee3}\x{753a}",
        'addr_name'      => '',
        'pref_kana'      => "\x{307b}\x{3063}\x{304b}\x{3044}\x{3069}\x{3046}",
        'city_kana'      => "\x{304a}\x{3073}\x{3072}\x{308d}\x{3057}",
        'data_type'      => 'p',
        'city'           => "\x{5e2f}\x{5e83}\x{5e02}",
        'other'          => '',
        'addr_name_kana' => '',
        'postcode'       => '0802336',
        'yid'            => '1763'
    }
  ];

