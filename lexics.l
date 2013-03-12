%{
#include <stdlib.h>

#include "qerl.h"
#include "grammar.tab.h"
%}

%option  nodefault yylineno

skipws [ \t\n]*
identifier [a-zA-Z_][a-zA-Z_0-9-]*

%%

{skipws}"#".*               {/* ignore comments */}
{skipws}\n{skipws}

{skipws}"("{skipws}         {return '(';}
{skipws}")"{skipws}         {return ')';}

{skipws}"["{skipws}         {return '[';}
{skipws}"]"{skipws}         {return ']';}

{skipws}"{"{skipws}         {return '{';}
{skipws}"}"{skipws}         {return '}';}

{skipws}"<"{skipws}         {return '<';}
{skipws}">"{skipws}         {return '>';}

{skipws}"+"{skipws}         {return '+';}
{skipws}"-"{skipws}         {return '-';}
{skipws}"*"{skipws}         {return '*';}
{skipws}"/"{skipws}         {return '/';}

{skipws}","{skipws}         {return ',';}
{skipws}";"{skipws}         {return ';';}
#{skipws}"\""{skipws}        {return '"';}
{skipws}"="{skipws}         {return '=';}

{skipws}"<="{skipws}        {return LESS_EQUAL;}
{skipws}">="{skipws}        {return MORE_EQUAL;}
{skipws}"=="{skipws}        {return EQUAL;}
{skipws}"!="{skipws}        {return NOT_EQUAL;}

{skipws}"≈"{skipws}         {return APPROXIMATE_EQUAL;} /* Alt+x on a Mac keyboad */
{skipws}"±"{skipws}         {return PLUS_MINUS;} /* Alt+Shift+Plus on a Mac keyboad */


[ \t\n]+                    {return WHITE_SPACE;}

"my"                        {return VARIABLE_DECLARATOR;}

{identifier}                {yylval.s = strndup(yytext, yyleng); return IDENTIFIER;}
"."{identifier}             {yylval.s = strndup(yytext, yyleng); return GLOBAL_IDENTIFIER;}

[+-]?[0-9]+                 {yylval.i = atoi(strndup(yytext, yyleng)); return INTEGER;}


.   {printf("bad input character '%s' at line %d\n", yytext, yylineno);}

%%
