%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    char* str;
}

%token<str> VAR

%%
start:
     VAR { printf("Valid variable: %s\n", $1); free($1); }
     ;
%%

int main(){
    printf("Enter a variable name: ");
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}