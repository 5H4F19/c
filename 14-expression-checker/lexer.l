%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
[0-9]+        { yylval.ival = atoi(yytext); return NUM; }
[-+*/%()]     { return *yytext; }    // Remove {} braces
[ \t\n]+      { /* Ignore whitespace */ }
.             { printf("Unknown character: %s\n", yytext); return 0; }
%%

int yywrap() {
    return 1;
}
