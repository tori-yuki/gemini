test : calc.exe test.in test.check
	./calc <test.in >test.out
	diff test.out test.check
calc.exe : calc.tab.o lex.yy.o
	gcc -o calc.exe calc.tab.o lex.yy.o
calc.tab.o : calc.tab.c
	gcc -c calc.tab.c
calc.tab.c : calc.y
	bison -d -v calc.y
lex.yy.o : lex.yy.c calc.tab.h
	gcc -c lex.yy.c
lex.yy.c : calc.l
	flex -I calc.l
calc.tab.h : calc.y
	bison -d -v calc.y