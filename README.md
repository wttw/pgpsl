psl 0.0.1
=========

This extension contains a single PostgreSQL function, registered_domain(),
that uses the [Public Suffix List](https://publicsuffix.org) to return
the registered domain within which a hostname exists.

Installation
------------

To build it, do this:

    make
    make install
    make installcheck

If you encounter an error such as:

    "Makefile", line 8: Need an operator

You need to use GNU make, which may well be installed on your system as
`gmake`:

    gmake
    gmake install
    gmake installcheck

If you encounter an error such as:

    make: pg_config: Command not found

Be sure that you have `pg_config` installed and in your path. If you used a
package management system such as RPM to install PostgreSQL, be sure that the
`-devel` package is also installed. If necessary tell the build process where
to find it:

    env PG_CONFIG=/path/to/pg_config make && make installcheck && make install

If you encounter an error such as:

    ERROR:  must be owner of database regression

You need to run the test suite using a super user, such as the default
"postgres" super user:

    make installcheck PGUSER=postgres

Once psl is installed you can add it to a database by running, as a
superuser:

    CREATE EXTENSION psl;

Usage
-----

`registered_domain()` will return the enclosing domain for any hostname,
folded to lower case.

For a registered domain it will return the domain itself. For a top level
domain or a hostname without periods it will return null.

As a special case, if passed an apparently correct hostname with a top level
domain it doesn't recognize it will return the final two components of the
hostname.

    steve=# select registered_domain('foo.bar.blighty.com');
     registered_domain
    -------------------
     blighty.com
    (1 row)
    
    steve=# select registered_domain('blighty.co.uk');
     registered_domain
    -------------------
     blighty.co.uk
    (1 row)
    
    steve=# select registered_domain('www.blighty.co.uk');
     registered_domain
    -------------------
     blighty.co.uk
    (1 row)
    
    steve=# select registered_domain('co.uk');
     registered_domain
    -------------------
    
    (1 row)
    
    steve=# select registered_domain('co.uk.ie');
     registered_domain
    -------------------
     uk.ie
    (1 row)

Copyright and License
---------------------

Copyright 2018 Steve Atkins

This module is free software; you can redistribute it and/or modify it under
the [PostgreSQL License](http://www.opensource.org/licenses/postgresql).

The core functionality is from
[regdom-libs](https://github.com/usrflo/registered-domain-libs/), code
released under the
[Apache license](http://www.apache.org/licenses/LICENSE-2.0).

Test vectors were taken from [libpsl](https://github.com/rockdaboot/libpsl),
under [MIT license](https://github.com/rockdaboot/libpsl/blob/master/LICENSE).

