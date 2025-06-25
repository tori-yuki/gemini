typedef enum ttype {
    number,    /* integer */
    plus,      /* addition operator + */
    hyphen,    /* substraction operator - */
    asterisk,  /* multiplication operator * */
    slash,     /* division operator / */
    tilde,     /* bitwise not ~ */
    ampersand, /* bitwise and & */
    pipe,      /* bitwise or | */
    openpar,   /* opening parentesis ( */
    closepar,  /* closing parentesis ) */
    semicolon, /* end of statement */
    error,
    eof,       /* end of file */
} ttype;

typedef struct token {
    ttype type;
    union {
        int    iv; /* for numbers */
        char*  cp; /* for identifiers */
    } val;
}
token;

void initScanner (void);
token getNextToken (void);