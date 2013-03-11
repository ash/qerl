qerl: qerl.c grammar.y lexics.l
	bison -d grammar.y
	flex -o lexics.lex.c lexics.l
	
	cc -c -o grammar.tab.o grammar.tab.c
	cc -c -o lexics.lex.o lexics.lex.c
	cc -c -o qerl.o qerl.c

	cc -o qerl qerl.o grammar.tab.o lexics.lex.o -ll
