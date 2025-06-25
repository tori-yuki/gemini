/*
 * dates.l - Lexer for a calculator for dates and periods
 */
%{
#include <stdio.h> // sscanfのために追加

/* dates.yと全く同じ定義をここに含める */
typedef struct {
    int year;
    int month;
    int day;
} TokenData;

#define YYSTYPE TokenData

/* bisonが生成するヘッダファイルをインクルード */
#include "dates.tab.h"

#undef yywrap
#define yywrap() 1
%}

%option noyywrap

%%

[0-9]{4}-[0-9]{2}-[0-9]{2} {
    sscanf(yytext, "%d-%d-%d", &yylval.year, &yylval.month, &yylval.day);
    return DATE;
}

P-?[0-9]+D {
    /* "P"と"D"を取り除いて数値部分を読み込む */
    sscanf(yytext + 1, "%d", &yylval.day);
    yylval.year = 0; yylval.month = 0;
    return PERIOD;
}

[0-9]+ {
    sscanf(yytext, "%d", &yylval.day);
    yylval.year = 0; yylval.month = 0;
    return NUM;
}

"+"     return PLUS;
"-"     return HYPHEN;
"*"     return ASTERISK;
"/"     return SLASH;
";"     return SEMICOLON;

"("     return OPENPAREN;
")"     return CLOSEPAREN;
"["     return OPENBRACKET;
"]"     return CLOSEBRACKET;
"{"     return OPENBRACE;
"}"     return CLOSEBRACE;

[ \t\n]+    ; /* whitespaceを無視 */

.   { fprintf(stderr, "Error: Unexpected character '%c'\n", *yytext); }

%%
