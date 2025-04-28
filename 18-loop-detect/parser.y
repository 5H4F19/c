%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(char *s);
extern FILE *yyin;

int nesting_level = 0;
int max_nesting = 0;
int syntax_error = 0;  // Flag to track syntax errors
int comma_in_condition = 0; // Flag to track comma in for loop condition
%}

%token FOR LPAREN RPAREN SEMICOLON LBRACE RBRACE ID NUMBER ASSIGN REL_OP INC_OP COMMA
%token IF ELSE PRINTF LOGICAL_OP  // Added LOGICAL_OP token for && and ||

%%
program:
    items
    ;

items:
    /* empty */
    | items item
    ;

item:
    loop
    | if_stmt
    | stmt
    | error SEMICOLON  /* Error recovery for statements */
    ;

loop:
    { nesting_level++; if (nesting_level > max_nesting) max_nesting = nesting_level; }
    FOR LPAREN stmt_opt for_condition expr_opt RPAREN stmt_or_block
    { nesting_level--; }
    ;

for_condition:
    for_expr SEMICOLON
    | error SEMICOLON { yyerror("Invalid for loop condition"); }
    ;

for_expr:
    ID
    | NUMBER
    | for_expr ASSIGN for_expr
    | for_expr REL_OP for_expr
    | for_expr LOGICAL_OP for_expr
    | for_expr INC_OP
    | for_expr COMMA for_expr { 
        comma_in_condition = 1; 
        yyerror("Comma operator not allowed in for loop condition"); 
      }
    ;

if_stmt:
    IF LPAREN expr RPAREN stmt_or_block
    | IF LPAREN expr RPAREN stmt_or_block ELSE stmt_or_block
    ;

stmt_or_block:
    stmt
    | block
    ;

block:
    LBRACE items RBRACE
    | LBRACE error RBRACE  /* Error recovery for blocks */
    ;

stmt_list:
    /* empty */
    | stmt_list stmt
    ;

stmt:
    expr_opt SEMICOLON
    | func_call SEMICOLON
    ;

expr_opt:
    expr
    | /* empty */
    ;

stmt_opt:
    stmt
    | /* empty */
    ;

expr:
    ID
    | NUMBER
    | expr ASSIGN expr
    | expr REL_OP expr
    | expr LOGICAL_OP expr  /* Added for logical expressions like a && b */
    | expr INC_OP
    | expr COMMA expr       /* Keep this for comma expressions in other contexts */
    ;

func_call:
    PRINTF LPAREN expr RPAREN
    ;

%%

int main(int argc, char *argv[]) {
    nesting_level = 0;
    max_nesting = 0;
    syntax_error = 0;
    comma_in_condition = 0;
    
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }
    
    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        printf("Error: Cannot open input file %s\n", argv[1]);
        return 1;
    }
    
    yyin = input_file;
    printf("Reading input from file: %s\n", argv[1]);
    
    if (yyparse() == 0 && !syntax_error && !comma_in_condition) {
        if (max_nesting >= 1)
            printf("Valid: Found loop: %d\n", max_nesting);
        else
            printf("Invalid: No for loop found.\n");
    } else {
        if (comma_in_condition) {
            printf("Invalid: Comma operator detected in for loop condition. Use logical operators (&&, ||) instead.\n");
        } else {
            printf("Invalid: Syntax errors found in for loop structure.\n");
        }
    }
    
    fclose(input_file);
    return 0;
}

int yyerror(char *s) {
    syntax_error = 1;
    printf("Error: %s\n", s);
    return 0;
}
