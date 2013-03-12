%{
#include <stdio.h>
#include "qerl.h"    
%}

%union {
    char* s;
    int i;
}

%token VARIABLE_DECLARATOR
%token <s> IDENTIFIER
%token <s> GLOBAL_IDENTIFIER
%token <i> INTEGER
%token VALUE
%token WHITE_SPACE

%type <s> variable_name

%nonassoc '<' '>' LESS_EQUAL MORE_EQUAL EQUAL NOT_EQUAL
%nonassoc APPROXIMATE_EQUAL PLUS_MINUS
%left '+' '-'
%left '*' '/'
%nonassoc UNARY_MINUS

%start programme

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
    VARIABLE_DECLARATOR WHITE_SPACE IDENTIFIER {printf("line %d: declared '%s'\n", yylineno, $3); /*declare_variable_IDENTIFIER(yylval.s);*/}
|   VARIABLE_DECLARATOR WHITE_SPACE IDENTIFIER '=' IDENTIFIER {printf("line %d: scalar declared '%s' and assigned to '%s'\n", yylineno, $3, $5);}
;

array_declaration:
    VARIABLE_DECLARATOR WHITE_SPACE IDENTIFIER '[' ']' {printf("line %d: array declared '%s'\n", yylineno, $3);}
;

hash_declaration:
    VARIABLE_DECLARATOR WHITE_SPACE IDENTIFIER '{' '}' {printf("line %d: hash declared '%s'\n", yylineno, $3);}
;

expression:
    '(' expression ')'
|   value
|   arithmetic_expression
|   comparison
|   string_concatenation
|   function_call
;

value:
    number
|   variable_name
|   indexed_array
|   indexed_hash
;

number:
    INTEGER
;

variable_name:
    IDENTIFIER
|   GLOBAL_IDENTIFIER
;

indexed_array:
    variable_name '[' INTEGER ']' {printf("line %d: array %s[], index %i\n", yylineno, $1, $3);}
;

indexed_hash:
    variable_name '{' IDENTIFIER '}' {printf("line %d: hash %s{}, indexed by variable '%s'\n", yylineno, $1, $3);}
|   variable_name '<' IDENTIFIER '>' {printf("line %d: hash %s{}, indexed by string '%s'\n", yylineno, $1, $3);}
;

arithmetic_expression:
   expression '+' expression {printf("line %d: addition\n", yylineno);}
|  expression '-' expression {printf("line %d: subtraction\n", yylineno);}
|  expression '*' expression {printf("line %d: multiplication\n", yylineno);}
|  expression '/' expression {printf("line %d: division\n", yylineno);}
|  '-' expression %prec UNARY_MINUS {printf("line %d: unary minus\n", yylineno);}
;

comparison:
    expression '<' expression {printf("line %d: less than\n", yylineno);}
|   expression '>' expression {printf("line %d: more than\n", yylineno);}
|   expression LESS_EQUAL expression {printf("line %d: less than or equal\n", yylineno);}
|   expression MORE_EQUAL expression {printf("line %d: more than or equal\n", yylineno);}
|   expression EQUAL expression {printf("line %d: equal\n", yylineno);}
|   expression NOT_EQUAL expression {printf("line %d: not equal\n", yylineno);}
|   expression APPROXIMATE_EQUAL expression PLUS_MINUS expression {printf("line %d: approximate equall\n", yylineno);}
;

string_concatenation:
|   expression WHITE_SPACE expression {printf("line %d: string concatenation\n", yylineno);}
;

function_call:
    IDENTIFIER '(' argument_list ')' {printf("line %d: function %s() call\n", yylineno, $1);}
;

argument_list:
    /* empty */
|   expression
|   expression ',' argument_list
;

%%

void yyerror(char *s, ...) {
    printf("Error at line %d\n", yylineno);
}
