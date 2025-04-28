%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
"for"             { return FOR; }
"if"              { return IF; }
"else"            { return ELSE; }
"printf"          { return PRINTF; }
"("               { return LPAREN; }
")"               { return RPAREN; }
"{"               { return LBRACE; }
"}"               { return RBRACE; }
";"               { return SEMICOLON; }
"="               { return ASSIGN; }
"<"|">"|"=="|"!="|"<="|">=" { return REL_OP; }
"&&"|"||"         { return LOGICAL_OP; }
"++"              { return INC_OP; }
[0-9]+            { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
[ \t\n]+          { /* ignore spaces, tabs, newlines */ }
"//".*            { /* ignore single-line comments */ }
"/*"([^*]|\*+[^*/])*"*/" { /* ignore multi-line comments */ }
","               { return COMMA; }
.                 { return yytext[0]; }
%%

int yywrap() { return 1; }
