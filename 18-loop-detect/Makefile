# Simple Makefile for loop-detect

all: parser scanner

parser: parser.y
	yacc -d parser.y

scanner: scanner.l y.tab.h
	flex scanner.l
	gcc -o loop-detect lex.yy.c y.tab.c -ll

clean:
	rm -f lex.yy.c y.tab.c y.tab.h loop-detect
