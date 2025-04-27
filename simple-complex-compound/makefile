all: lexer

lexer: lexer.l
	flex lexer.l
	gcc -o sentence lex.yy.c -ll

clean:
	rm -f sentence lex.yy.c
