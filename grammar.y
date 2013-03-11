%{
#include <stdio.h>
#include "qerl.h"    
%}

%token VARIABLE_DECLARATOR
%token <s> NAME
%token VALUE
%token WS

%start programme

%union {
    char* s;
}

%%

programme:
   statementlist
;

statementlist:
    /* empty */
|   statement
|   codeblock statementlist
|   statement ';' statementlist
;

codeblock:
    '{' statementlist '}'
|   statement
;

statement:
    /* empty */ /* {printf("line %d: empty statement\n", yylineno);} */
|   declaration
|   expression
;


declaration:
    VARIABLE_DECLARATOR WS NAME {printf("line %d: declared '%s'\n", yylineno, $3); /*declare_variable_name(yylval.s);*/}
|   VARIABLE_DECLARATOR WS NAME '=' NAME {printf("line %d: declared '%s' and assigned to '%s'\n", yylineno, $3, $5);}
;

expression:
    NAME '+' NAME {printf("line %d: added %s and %s\n", yylineno, $1, $3);}
;

%%

void yyerror(char *s, ...) {
    printf("Error at line %d\n", yylineno);
}
