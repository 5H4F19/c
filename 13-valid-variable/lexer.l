%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
[a-zA- -Z0-9_]* { printf("Valid variable name: %s\n",yytext); yylval.str = strdup(yytext); return VAR;}
. { return yytext[0]; }
[ \t\n]+ {}
%%

int yywrap() {
    return 1;
}