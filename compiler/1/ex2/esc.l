    int num_lines = 0, num_chars = 0;
%%


"&"     { printf("&amp;"); }
"<"     { printf("&lt;"); }
">"     { printf("&gt;"); }
"'"     { printf("&apos;"); }
"\""    { printf("&quot;"); }
.       { putchar(yytext[0]); }  // 他はそのまま出力
\n      { putchar('\n'); }       // 改行も維持

%%
int main(void)
{
    yylex();
    printf( "%d lines, %d characters\n",
        num_lines, num_chars );
}

int yywrap () { return 1; }