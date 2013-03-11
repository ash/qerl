%{
#include <stdio.h>
#include "qerl.h"    
%}

%token VARIABLE_DECLARATOR
%token <s> IDENTIFIER
%token <s> GLOBAL_IDENTIFIER
%token <i> INTEGER
%token VALUE
%token WS

%type <s> variable_name

%start programme

%union {
    char* s;
    int i;
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
    scalar_declaration
|   array_declaration
|   hash_declaration
;

scalar_declaration:
    VARIABLE_DECLARATOR WS IDENTIFIER {printf("line %d: declared '%s'\n", yylineno, $3); /*declare_variable_IDENTIFIER(yylval.s);*/}
|   VARIABLE_DECLARATOR WS IDENTIFIER '=' IDENTIFIER {printf("line %d: scalar declared '%s' and assigned to '%s'\n", yylineno, $3, $5);}
;

array_declaration:
    VARIABLE_DECLARATOR WS IDENTIFIER '[' ']' {printf("line %d: array declared '%s'\n", yylineno, $3);}
;

hash_declaration:
    VARIABLE_DECLARATOR WS IDENTIFIER '{' '}' {printf("line %d: hash declared '%s'\n", yylineno, $3);}
;


expression:
    variable_name
|   expression '+' expression {printf("line %d: addition\n", yylineno); /*printf("line %d: added %s and %s\n", yylineno, $1, $3);*/}
|   indexed_array
|   indexed_hash
;

variable_name:
    IDENTIFIER
|   GLOBAL_IDENTIFIER
;

indexed_array:
    variable_name '[' INTEGER ']' {printf("line %d: array %s, index %i\n", yylineno, $1, $3);}
;

indexed_hash:
    variable_name '{' IDENTIFIER '}' {printf("line %d: hash %s, index '%s'\n", yylineno, $1, $3);}
;

%%

void yyerror(char *s, ...) {
    printf("Error at line %d\n", yylineno);
}
