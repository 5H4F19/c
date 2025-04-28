all: lexer

lexer: lexer.l
	flex lexer.l
	gcc -o integer lex.yy.c -ll

clean:
	rm -f integer lex.yy.c
