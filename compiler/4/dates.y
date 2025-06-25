/* dates.y - A calculator for dates and periods (Error handling fixed) */
/* Name: 青山 太郎 (AOYAMA Taro) */
/* Student Number: 12345678 */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int year;
    int month;
    int day;
} TokenData;

#define YYSTYPE TokenData

int yylex(void);
void yyerror(const char *s);

int to_julian(int y, int m, int d);
void from_julian(int jd, int *y, int *m, int *d);

#define YYDEBUG 0
%}

%token DATE PERIOD NUM
%token PLUS HYPHEN ASTERISK SLASH
%token OPENPAREN CLOSEPAREN
%token OPENBRACKET CLOSEBRACKET
%token OPENBRACE CLOSEBRACE
%token SEMICOLON

%%
program:
    program statement
    | /* empty */
    ;

statement:
    date_exp SEMICOLON   { printf("Result is %04d-%02d-%02d\n", $1.year, $1.month, $1.day); }
    | period_exp SEMICOLON { printf("Result is P%dD\n", $1.day); }
    | int_exp SEMICOLON    { printf("Result is %d\n", $1.day); }
    | SEMICOLON            { }
    | error SEMICOLON      {
        yyerrok;
        fflush(stdout);
        fprintf(stderr, "statement error\n");
    }
    ;

int_exp:
    int_exp PLUS int_term     { $$.day = $1.day + $3.day; $$ = (TokenData){0, 0, $$.day}; }
    | int_exp HYPHEN int_term { $$.day = $1.day - $3.day; $$ = (TokenData){0, 0, $$.day}; }
    | int_term                { $$ = $1; }
    ;

int_term:
    int_term ASTERISK int_factor { $$.day = $1.day * $3.day; $$ = (TokenData){0, 0, $$.day}; }
    | int_term SLASH int_factor   {
        if ($3.day != 0) $$.day = $1.day / $3.day;
        else { fflush(stdout); yyerror("statement error"); $$.day = 0; }
        $$ = (TokenData){0, 0, $$.day};
    }
    | int_factor                  { $$ = $1; }
    ;

int_factor:
    OPENPAREN int_exp CLOSEPAREN { $$ = $2; }
    | HYPHEN int_factor            { $$ = (TokenData){0, 0, -$2.day}; }
    | PLUS int_factor              { $$ = $2; }
    | NUM                          { $$ = $1; }
    ;

period_exp:
    OPENBRACE period_body CLOSEBRACE { $$ = $2; }
    | PERIOD                         { $$ = $1; }
    ;

period_body:
    period_exp PLUS period_exp     { $$ = (TokenData){0, 0, $1.day + $3.day}; }
    | period_exp HYPHEN period_exp { $$ = (TokenData){0, 0, $1.day - $3.day}; }
    | date_exp HYPHEN date_exp     {
        int jd1 = to_julian($1.year, $1.month, $1.day);
        int jd2 = to_julian($3.year, $3.month, $3.day);
        $$ = (TokenData){0, 0, jd1 - jd2};
    }
    | period_exp ASTERISK int_exp  { $$ = (TokenData){0, 0, $1.day * $3.day}; }
    | int_exp ASTERISK period_exp  { $$ = (TokenData){0, 0, $1.day * $3.day}; }
    | period_exp SLASH int_exp     {
        if ($3.day != 0) $$ = (TokenData){0, 0, $1.day / $3.day};
        else { fflush(stdout); yyerror("statement error"); $$ = (TokenData){0, 0, 0}; }
    }
    ;

date_exp:
    OPENBRACKET date_body CLOSEBRACKET { $$ = $2; }
    | DATE                             { $$ = $1; }
    ;

date_body:
    date_exp PLUS period_exp  {
        int jd = to_julian($1.year, $1.month, $1.day) + $3.day;
        from_julian(jd, &($$.year), &($$.month), &($$.day));
    }
    | period_exp PLUS date_exp {
        int jd = $1.day + to_julian($3.year, $3.month, $3.day);
        from_julian(jd, &($$.year), &($$.month), &($$.day));
    }
    | date_exp HYPHEN period_exp {
        int jd = to_julian($1.year, $1.month, $1.day) - $3.day;
        from_julian(jd, &($$.year), &($$.month), &($$.day));
    }
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

const int days_in_month[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
const int days_before_month[] = {0, 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334};

int to_julian(int y, int m, int d) {
    if (m < 1 || m > 12 || d < 1 || d > days_in_month[m]) return 0;
    return (y - 1) * 365 + days_before_month[m] + d;
}

void from_julian(int jd, int *y, int *m, int *d) {
    *y = (jd - 1) / 365 + 1;
    int day_of_year = (jd - 1) % 365 + 1;
    for (*m = 1; *m <= 12; (*m)++) {
        if (day_of_year <= days_before_month[*m] + days_in_month[*m]) {
            *d = day_of_year - days_before_month[*m];
            return;
        }
    }
}

int main(void) {
    yyparse();
    return 0;
}
