    int num_lines = 0, num_chars = 0;
%%
[0-9]{4}(-[0-9]{2})?(-[0-9]{2})?   {  /*yyyy/mm/dd*/
    int y, m, d;
    if(sscanf(yytext, "%4d-%2d-%2d", &y, &m, &d) == 3)
      printf("year: %d, month: %d, day: %d\n", y, m, d);
	else if(sscanf(yytext, "%4d-%2d", &y, &m) == 2)
	  printf("year: %d, month: %d\n", y, m );
	else if(sscanf(yytext, "%4d", &y) == 1) 
	  printf("year: %d\n", y);
}

[0-9]{4}-[0-9]{3} { /*yyyy/ddd*/
    int y, d;
	sscanf(yytext, "%4d-%3d", &y, &d);
	printf("year: %d, day: %03d\n", y, d);
}

[0-9]{4}-[0-9]{2}-[0-9] { /*yyyy/Www/d*/
    int y, w, wd;
    sscanf(yytext, "%4d-%2d-%2d", &y, &w, &wd);
	printf("year: %d, week: %d, weekday: %d\n", y, w, wd);
}

[0-9]{2}:[0-9]{2}(:[0-9]{2})?   {  /*hour/minute/second*/
    int h, m, s = 0;
    if (sscanf(yytext, "%2d:%2d:%2d", &h, &m, &s) == 3)
        printf("hour: %d, min: %d, sec: %d\n", h, m, s);
    else if (sscanf(yytext, "%2d:%2d", &h, &m) == 2)
        printf("hour: %d, min: %d\n", h, m);
}

.       {  }
\n      { putchar('\n'); }
%%
int main(void)
{
    yylex();
    printf( "%d lines, %d characters\n",
        num_lines, num_chars );
}

int yywrap () { return 1; }