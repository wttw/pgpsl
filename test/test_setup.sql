\set QUIET 1

-- Format the output for nice TAP.
\pset format unaligned
\pset tuples_only true
\pset pager

-- Revert all changes on failure.
\set ON_ERROR_ROLLBACK 1
\set ON_ERROR_STOP true

-- Actually load the extension
set client_min_messages = warning;
create extension if not exists psl;
set client_min_messages = notice;

-- Load the TAP functions.
BEGIN;
\i test/pgtap/pgtap-core.sql
