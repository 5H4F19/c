%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%token A B

%%

start:
    S '\n' { printf("Accepted\n");}
    ;
S:
    A S B
    | A B
    ;
%%

int main(){
    printf("Enter a string: ");
    yyparse();
    return 0;
}

int yyerror(const char *s){
    printf("Not accepted\n");
    return 0;
}