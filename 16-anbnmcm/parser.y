%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
int yyerror(const char *s);
extern FILE* yyin;
void yyrestart(FILE* input_file);
%}

%%
start:
     S { printf("String is in the language\n"); }
S:
 A B
 ;
A:
  'a' A 'b'
  |
  ;
B:
   'b' B 'c'
  |
 ;
%%

int main() {
    char input[100];
    
    while(1) {
        printf("Enter string (or 'exit' to quit): ");
        if(fgets(input, sizeof(input), stdin) == NULL) {
            break;
        }
        
        // Check for exit command
        if(strncmp(input, "exit", 4) == 0) {
            break;
        }
        
        // Create a temporary file for input
        FILE* temp = tmpfile();
        if(!temp) {
            fprintf(stderr, "Failed to create temporary file\n");
            continue;
        }
        
        // Write input to file and rewind
        fputs(input, temp);
        rewind(temp);
        
        // Set input source and parse
        yyin = temp;
        yyrestart(yyin);
        yyparse();
        
        // Close the temp file
        fclose(temp);
    }
    
    return 0;
}

int yyerror(const char *s) {
    printf("Wrong format: %s\n", s);
    return 0;
}
