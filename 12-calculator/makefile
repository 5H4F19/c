all: parser lexer

lexer: lexer.l
	flex lexer.l
	gcc -o calc lex.yy.c y.tab.c -ll

parser: parser.y
	yacc -d parser.y

clean:
	rm -f calc lex.yy.c y.tab.c y.tab.h
