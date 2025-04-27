all: lexer

lexer: lexer.l
	flex lexer.l
	gcc -o exponential lex.yy.c -ll

clean:
	rm -f exponential lex.yy.c
