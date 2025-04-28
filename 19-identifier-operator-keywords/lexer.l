%{
#include <stdio.h>
extern FILE *yyin;
%}

%%
(int|float|double|char|void|if|else|while|for|return|break|continue|switch|case|default|goto|sizeof|typedef|struct|union|enum|const|volatile|register|extern|static|inline) {
    printf("Keyword: %s\n", yytext);
}
[-+*=/*%&|^~<>!={}();]+ {
    printf("Operator: %s\n", yytext);
}
[a-zA-Z_][a-zA-Z0-9_]* {
    printf("Identifier: %s\n", yytext);
}
[0-9]+ {
    printf("Integer: %s\n", yytext);
}
[ \t\n]+ {}
%%

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("fopen");
            return 1;
        }
    }
    yylex();
    if (yyin && yyin != stdin) fclose(yyin);
    return 0;
}
int yywrap() {
    return 1;
}