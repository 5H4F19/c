%{
#include <stdio.h>

int char_count = 0;
int word_count = 0;
int line_count = 0;
int space_count = 0;
%}

%%
\n {line_count++;char_count++;}
[ \t]+ {space_count += yyleng;char_count += yyleng;}
[a-zA-Z0-9_]+ {word_count++;char_count += yyleng;}
. { char_count++; }
%%

int main() {
    yylex();
    printf("\n");
    printf("Characters: %d\n", char_count);
    printf("Words: %d\n", word_count);
    printf("Lines: %d\n", line_count);
    printf("Spaces: %d\n", space_count);
    return 0;
}
int yywrap() {
    return 1;
}


