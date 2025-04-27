%{
#include <stdio.h>
%}

%%
(am|is|are|was|were|be|being|been) {
    printf("To be Verb: %s\n", yytext);
}
[a-zA-Z_][a-zA-Z0-9_]* {
    printf("Identifier: %s\n", yytext);
}
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