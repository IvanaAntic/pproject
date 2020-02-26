bison -d project.y
flex --noyywrap project.l
gcc -o project project.tab.c lex.yy.c
./project <ulaz.txt
