#include <stdio.h>
#include <stdlib.h>
#include "scanner.h"

int nextChar;   /* always contains next character to look at */

void initScanner (void) {
    nextChar = getchar();
}

token num() {
    token t;
    long n = 0;

    while ('0' <= nextChar && nextChar <= '9') {
        n = n*10 + (nextChar-'0');
        nextChar = getchar();
    }
    t.type = number;
    t.val.iv = n;
    return t;
}

token getNextToken (void) {
    token t;
    
    while (nextChar==' ' || nextChar=='\t' || nextChar=='\n')
        nextChar = getchar(); /* ignore whitespace */
    if ('0' <= nextChar && nextChar <= '9')
        return num();
    /* else if ('A' <= nextChar && nextChar <= 'Z'
             || 'a' <= nextChar && nextChar <= 'z')
        return identOrKey (); */
    switch (nextChar) {
      case EOF:  t.type = eof;        break;
      case '+':  t.type = plus;       break;
      case '-':  t.type = hyphen;     break;
      case '*':  t.type = asterisk;   break;
      case '/':  t.type = slash;      break;
      case '~':  t.type = tilde;      break;
      case '&':  t.type = ampersand;  break;
      case '|':  t.type = pipe;       break;
      case '(':  t.type = openpar;    break;
      case ')':  t.type = closepar;   break;
      case ';':  t.type = semicolon;  break;
      default:   t.type = error;      break;
    }
    nextChar = getchar();
    return t;
}