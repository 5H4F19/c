all: lexer

lexer: lexer.l
	flex lexer.l
	gcc -o counter lex.yy.c -ll

clean:
	rm -f counter lex.yy.c
