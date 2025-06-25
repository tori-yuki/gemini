/* parser for simple expressions */
/* Grammar:
   Statement 竊� Expression ';'
   Expression 竊� Term '+' Term
              | Term
   Term 竊� number
*/

#include <stdio.h>
#include <stdlib.h>
#include "scanner.h"

token nextToken;

int Statement();  // forward declarations
int Expression(); // (also needed for
int Term();       //  mutual recursion)


int main () {    
    initScanner();
    nextToken = getNextToken(); // get first token
    Statement();
    
    return 0;
}

int Statement() {
    int value = Expression();

    if (nextToken.type == semicolon) {
        printf ("Result is %d\n", value);
        // semicolon is last token, so we do not need a next one,
        // but this needs to be uncommented if we have multiple statements
        // nextToken = getNextToken();
    }
    else printf("Error: Missing semicolon!\n"), exit(1);
}

int Expression() {
    int r = Term();

    if (nextToken.type == plus) {
         nextToken = getNextToken();
         r += Term();
    }
	else if (nextToken.type == hyphen ) 
         nextToken = getNextToken();
         r -= Term();

    return r;
}

int Term() {
    int r;
    
    if (nextToken.type == number) {
        r = nextToken.val.iv;
        nextToken = getNextToken();
    }
    else printf("Error: Number expected but not found!\n"), exit(1);
    
    return r;
}