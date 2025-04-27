all: lexer

lexer: lexer.l
	flex lexer.l
	gcc -o toBeVerb lex.yy.c -ll

clean:
	rm -f toBeVerb lex.yy.c
