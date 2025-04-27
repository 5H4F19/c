all: parser lexer

parser: parser.y
	yacc -d parser.y

lexer: lexer.l
	flex lexer.l
	gcc -o anbn lex.yy.c y.tab.c -ll

clean:
	rm -f anbn lex.yy.c y.tab.c y.tab.h
