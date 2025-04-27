%{
#include <stdio.h>
#include <stdlib.h>

int comment_lines = 0;  // Variable to count the number of comment lines
FILE *output_file;      // Output file pointer
%}

%%
"//".*                  { comment_lines++; }  // Match single-line comments
"/*"[^*]*"*/"           { comment_lines++; }  // Simple multi-line comments
"/*"([^*]|\*+[^/])*"*"+"/" { comment_lines++; }  // Complex multi-line comments with nested asterisks
.|\n                    { fputc(yytext[0], output_file); }  // Copy other content to the output file
%%

int main(int argc, char *argv[]) {

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening input file");
        exit(1);
    }

    output_file = fopen("cleaned_output.c", "w");
    if (!output_file) {
        perror("Error opening output file");
        fclose(input_file);
        exit(1);
    }

    yyin = input_file;  // Set input file for lex
    yylex();             // Start the lexical analysis
    fclose(input_file);  // Close input file
    fclose(output_file); // Close output file

    printf("Number of comment lines: %d\n", comment_lines);
    return 0;
}

int yywrap() {
    return 1;  // Indicate end of input
}