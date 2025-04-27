%{
#include <stdio.h>
#include <stdlib.h>

int a_count = 0;
int b_count = 0;
int c_count = 0;

int yylex();
int yyerror(const char *s);
%}

%%
start:
    sequence
    {
        if (b_count == a_count + c_count) {
            printf("✅ Valid string.\n");
        } else {
            printf("❌ Invalid string.\n");
        }
    }
    ;

sequence:
    a_part b_part c_part
    ;

a_part:
    /* empty */
    |
    a_part 'a' { a_count++; }
    ;

b_part:
    /* empty */
    |
    b_part 'b' { b_count++; }
    ;

c_part:
    /* empty */
    |
    c_part 'c' { c_count++; }
    ;
%%

int main() {
    printf("Enter string: ");
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    printf("Parse error: %s\n", s);
    return 0;
}
