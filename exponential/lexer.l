%{
#include <stdio.h>
%}

%%
-?([0-9]+([.][0-9]+)?)[eE][-+]?[0-9]+ { printf("exponential: %s\n",yytext);}
[ \t\n]+          { /* Ignore whitespace */ }
.                 { printf("Invalid character: %s\n", yytext); }
%%

int main(){
    yylex();
    return 0;
}
int yywrap() {
    return 1;
}

