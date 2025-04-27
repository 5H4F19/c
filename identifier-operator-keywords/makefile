all: lexer

lexer: lexer.l
	flex lexer.l
	gcc -o classifier lex.yy.c -ll

clean:
	rm -f classifier lex.yy.c
