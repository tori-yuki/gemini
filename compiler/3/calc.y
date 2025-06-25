/* calc.y - 構文解析定義ファイル */

%{
#include <stdio.h>
#include <stdlib.h>

/* 値の型を double に設定 */
#define YYSTYPE double

int yylex(void);
void yyerror(const char *s);
%}

/* トークンの宣言（scannerと一致させる） */
%token NUM
%token PLUS HYPHEN ASTERISK SLASH
%token SEMICOLON OPENPAREN CLOSEPAREN

%%

/* 文の並び：複数の計算文を処理可能に */
statement_list:
    /* 空 */
  | statement statement_list
;

/* 計算式とセミコロンで文を構成 */
statement:
    exp SEMICOLON   { printf("Result is %g\n", $1); }
  | error SEMICOLON { yyerror("構文エラーです"); yyerrok; }
;

/* 加算・減算は優先度が低いのでexp */
exp:
    exp PLUS term   { $$ = $1 + $3; }
  | exp HYPHEN term { $$ = $1 - $3; }
  | term
;

/* 乗算・除算はexpより優先度が高いのでterm */
term:
    term SLASH factor {
        if ($3 == 0) {
            printf("0による除算です");
			exit(1);
        } else {
            $$ = $1 / $3;
        }
    }
  | term ASTERISK factor { $$ = $1 * $3; }
  | factor
;

/* 単項マイナスや括弧、数値 */
factor:
    HYPHEN factor        { $$ = -$2; } // 単項マイナス
  | OPENPAREN exp CLOSEPAREN { $$ = $2; }
  | NUM
;

%%

/* メイン関数 */
int main(void) {
    return yyparse();
}

/* エラーメッセージ出力 */
void yyerror(const char *s) {
    fprintf(stderr, "エラー: %s\n", s);
}
