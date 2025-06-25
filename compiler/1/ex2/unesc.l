    int num_lines = 0, num_chars = 0;
%%


"&lt;"     { printf("<"); }
"&gt;"     { printf(">"); }
"&apos;"   { printf("'"); }
"&quot;"   { printf("\""); }
"&amp;"    { printf("&"); }
.          { putchar(yytext[0]); }
\n         { putchar('\n'); }

%%
int main(void)
{
    yylex();
    printf( "%d lines, %d characters\n",
        num_lines, num_chars );
}

int yywrap () { return 1; }