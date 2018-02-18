\unset ECHO
\i test/test_setup.sql

select plan(25);

select is(registered_domain('www.example.com'), 'example.com');
select is(registered_domain('com.ar'), null);
select is(registered_domain('www.com.ar'), 'www.com.ar');
select is(registered_domain('cc.ar.us'), null);
select is(registered_domain('.cc.ar.us'), null);
select is(registered_domain('www.cc.ar.us'), 'www.cc.ar.us');

-- www.ck is an exception to the general .ck rules
select is(registered_domain('www.ck'), 'www.ck');
select is(registered_domain('abc.www.ck'), 'www.ck');
select is(registered_domain('xxx.ck'), null);
select is(registered_domain('www.xxx.ck'), 'www.xxx.ck');

-- aka xn--czr694b
select is(registered_domain('\345\225\206\346\240\207'), null);
select is(registered_domain(E'www.\345\225\206\346\240\207'), E'www.\345\225\206\346\240\207');

-- name and forgot.his.name are public, his.name isn't
select is(registered_domain('name'), null);
select is(registered_domain('.name'), null);
select is(registered_domain('his.name'), null);
select is(registered_domain('.his.name'), null);
select is(registered_domain('forgot.his.name'), null);
select is(registered_domain('.forgot.his.name'), null);
select is(registered_domain('whoever.his.name'), 'whoever.his.name');
select is(registered_domain('whoever.forgot.his.name'), 'whoever.forgot.his.name');
select is(registered_domain('.'), null);
select is(registered_domain(''), null);
select is(registered_domain(null), null);

-- hopefully unregistered TLD
select is(registered_domain('adfhoweirh'), null);
select is(registered_domain('www.foo.adfhoweirh'), 'foo.adfhoweirh');

select * from finish();
rollback;

