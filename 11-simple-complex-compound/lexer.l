%{
#include <stdio.h>
int Conjunction = 0;
int SubordinatingConjunction = 0;
%}

%%
(and|or|but|yet) { Conjunction++;}
(because|although|since|if|unless) { SubordinatingConjunction++; }
[a-zA-Z0-9_]+ {}
[ \t\n]+ {}
. {}
%%

int main(){
   
    yylex();
    
    if (SubordinatingConjunction > 0) {
        printf("Complex Sentence\n");
    } else if (Conjunction > 0) {
        printf("Compound Sentence\n");
    } else {
        printf("Simple Sentence\n");
    }
    return 0;
}
int yywrap(){
    return 1;
}