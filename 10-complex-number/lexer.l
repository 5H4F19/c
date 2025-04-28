%{
#include <stdio.h>
%}

%%
-?[0-9]+(\.[0-9]+)?[-+][0-9](\.[0-9]+)?+i { printf("Complex number: %s\n",yytext);}
[ \t\n]+ {}
. {}
%%

int main(){
    yylex();
    return 0;   
}

int yywrap() {
    return 1;
}