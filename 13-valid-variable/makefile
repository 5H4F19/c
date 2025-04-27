all: parser lexer
parser: parser.y
	yacc -d parser.y

lexer: lexer.l
	flex lexer.l
	gcc -o validity lex.yy.c lex.yy.c -ll