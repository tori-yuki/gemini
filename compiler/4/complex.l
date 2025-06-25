/*
 * flex
 */

%{
#define YYSTYPE double
#include "calc.tab.h"
#undef yywrap
#define yywrap() 1
%}
%option noyywrap
%%

[0-9]+(\.[0-9]*)?  {
            yylval = atof(yytext);
            return NUM;
        }
"+"     return PLUS;

"-"     return HYPHEN;

"*"     return ASTERISK;

"/"     return SLASH;

";"     return SEMICOLON;

"("     return OPENPAREN;

")"     return CLOSEPAREN;

[ \t\r\n]    ;

%%
