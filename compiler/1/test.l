    int num_lines = 0, num_chars = 0;
%%
\n  ++num_lines; ++num_chars;
.   ++num_chars;

%%
int main(void)
{
    yylex();
    printf( "%d lines, %d characters\n",
        num_lines, num_chars );
}

int yywrap () { return 1; }