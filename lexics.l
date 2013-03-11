%{
#include <stdlib.h>

#include "qerl.h"
#include "grammar.tab.h"
%}

%option  nodefault yylineno

skipws [ \t\n]*

%%

{skipws}"#".*               {/* ignore comments */}
{skipws}\n{skipws}

{skipws}"{"{skipws}         {return '{';}
{skipws}"}"{skipws}         {return '}';}

{skipws}"+"{skipws}         {return '+';}

{skipws}";"{skipws}         {return ';';}
{skipws}"="{skipws}         {return '=';}

[ \t\n]+                    {return WS;}


"my"                        {return VARIABLE_DECLARATOR;}

[a-zA-Z_][a-zA-Z_0-9-]+     {yylval.s = strndup(yytext, yyleng); return NAME;}

.   {printf("bad input character '%s' at line %d\n", yytext, yylineno);}

%%
