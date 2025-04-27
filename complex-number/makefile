all: lexer

lexer: lexer.l
	flex lexer.l
	gcc -o complex lex.yy.c -ll

clean:
	rm -f complex lex.yy.c
