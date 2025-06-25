    int num_lines = 0, num_chars = 0;
%%

[0-9]+      { printf(">*>%s<*<", yytext); }
.           { putchar(yytext[0]); }
\n          { putchar('\n'); }

%%
int main(void)
{
    yylex();
    printf( "%d lines, %d characters\n",
        num_lines, num_chars );
}

int yywrap () { return 1; }