\echo Use "CREATE EXTENSION psl" to load this file. \quit
CREATE FUNCTION _registered_domain(text) RETURNS text
AS '$libdir/psl', 'registered_domain'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION registered_domain(text) RETURNS text AS $$
select _registered_domain(lower($1));
$$ LANGUAGE SQL IMMUTABLE STRICT;
