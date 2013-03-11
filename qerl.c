#include <stdio.h>
#include <stdlib.h>

#include "qerl.h"
#include "grammar.tab.h"

int main() {
    return yyparse();
}
