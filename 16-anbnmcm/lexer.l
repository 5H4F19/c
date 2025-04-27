%{
#include "y.tab.h"
%}

%%
a   { return 'a'; }
b   { return 'b'; }
c   { return 'c'; }
[ \t\n] { /* Ignore whitespace */ }
.   { return yytext[0]; }
%%

int yywrap() {
    return 1;
}
