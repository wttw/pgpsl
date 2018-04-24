#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"

#include "regdom.h"

PG_MODULE_MAGIC;

void *tree = 0;

PG_FUNCTION_INFO_V1(registered_domain);
Datum registered_domain(PG_FUNCTION_ARGS) {
  text *in = PG_GETARG_TEXT_P(0);
  char *ret;

  if (0 == tree) {
    tree = loadTldTree();
  }

  ret = getRegisteredDomain(text_to_cstring(in), tree);

  if (0 == ret) {
    PG_RETURN_NULL();
  }
  
  PG_RETURN_TEXT_P(cstring_to_text(ret));
}
