EXTENSION = psl
EXTVERSION = 0.0.1
DATA = sql/psl--$(EXTVERSION).sql
MODULE_big = psl
OBJS = src/pgpsl.o src/regdom.o
TESTS = $(wildcard test/sql/*.sql)
REGRESS = $(patsubst test/sql/%.sql,%,$(TESTS))
REGRESS_OPTS = --inputdir=test # --load-language plpgsql
DOCS = README.md
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

.PHONY: tidy
tidy: clean
	rm -f *~ sql/*~ src/*~ test/*~ test/sql/*~

.PHONY: test
test:
	pg_prove --ext .sql test/sql

# Fetch and obfuscate a new copy of the PSL
.PHONY: fetch
fetch:
	php src/generateEffectiveTLDs.php c >src/tld-canon.h

.PHONY: package
package:
	git archive --format zip --prefix=psl-$(EXTVERSION)/ --output /tmp/psl-$(EXTVERSION).zip master
