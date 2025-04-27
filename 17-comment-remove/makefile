all: parser
parser: lexer.l
	flex lexer.l
	gcc -o comment-remover lex.yy.c -ll
clean:	
	rm -f comment-remover lex.yy.c cleaned_output.c