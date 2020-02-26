%option noyywrap yylineno
%x COMMENT
%{
  #include <string.h>
  #include "project.tab.h"
  
%}

%%

"/*" { BEGIN COMMENT;}
<COMMENT>.|\n 
<COMMENT>"*/" {BEGIN INITIAL;}


"//".*  { /* LINIJSKI KOMENTARI */ }

[ \t\n]+            { /* skip */ }

"miris"             { yylval.s = strdup(yytext); return _PROPERTY; }
"ukus"		        { yylval.s = strdup(yytext); return _PROPERTY; }
"providnost"	    { yylval.s = strdup(yytext); return _PROPERTY; }

"("                 { return _LPAREN; }
")"                 { return _RPAREN; }

";"                 { return _SEMICOLON; }
":"                 { return _COLON; }
"="                 { return _ASSIGN; }
"."		     		{ return _DOT;}
","			      	{ return _COMMA;}
"/"		     		{ yylval.s = strdup(yytext); return _SYMBOL; }
"*"		     		{ yylval.s = strdup(yytext); return _SYMBOL; }
"+"                 { yylval.s = strdup(yytext); return _SYMBOL; }
"-"                 { yylval.s = strdup(yytext); return _SYMBOL; }

"->"                { return _ARROW; }

 
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.s = strdup(yytext); return _ID;}
	
[+-]?[0-9]{1,10}     { yylval.s = strdup(yytext); return _NUMBER;}



.                   { printf("line %d: LEXICAL ERROR on char %c\n", 
                              yylineno, *yytext);}
%%
