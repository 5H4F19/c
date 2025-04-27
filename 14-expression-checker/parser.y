%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyerror(char *s);
%}

%union {
    int ival;
}

%token <ival> NUM
%type  <ival> expr
%left '+' '-'
%left '*' '/'

%%
start:
    expr { printf("Valid expression"); }
    ;

expr:
    expr '+' expr { $$ = $1 + $3; }
  | expr '-' expr { $$ = $1 - $3; }
  | expr '*' expr { $$ = $1 * $3; }
  | expr '/' expr { 
        if ($3 == 0) {
            yyerror("Division by zero");
            YYABORT;
        } else {
            $$ = $1 / $3;
        }
    }
  | '(' expr ')' { $$ = $2; }
  | NUM { $$ = $1; }
  ;
%%

int main() {
    yyparse();
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr,"Invalid expression: \n%s\n", s);
    return 0;
}
