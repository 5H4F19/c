all: parser lexer

parser: parser.y
	yacc -d parser.y

lexer: lexer.l
	flex lexer.l
	gcc -o anbnmcm lex.yy.c y.tab.c -ll

clean:
	rm -f anbnmcm lex.yy.c y.tab.c y.tab.h
