use inc::Module::Install;
name 'XMLRPC-Fluent';
all_from 'lib/XMLRPC/Fluent.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
