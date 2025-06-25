test : dates.exe test.in test.check
	./dates <test.in >test.out
	diff test.out test.check
dates.exe : dates.tab.o lex.yy.o
	gcc -o dates.exe dates.tab.o lex.yy.o
dates.tab.o : dates.tab.c
	gcc -c dates.tab.c
dates.tab.c : dates.y
	bison -d -v dates.y
lex.yy.o : lex.yy.c dates.tab.h
	gcc -c lex.yy.c
lex.yy.c : dates.l
	flex -I dates.l
dates.tab.h : dates.y
	bison -d -v dates.y