   /* cs152-calculator */
   
%{   
   /* write your C code here for defination of variables and including headers */
   int currLine = 1;
   int currPos = 1;

   int integerNum=0, operatorsNum=0, parenthesisNum=0, equalNum=0;
%}


   /* some common rules, for example DIGIT */
NAT            [0-9]+
SIGNED_NAT     [+-]?{NAT}
DECIMAL_NUM    {SIGNED_NAT}\.{NAT}
SCIENTIFIC_NAT {SIGNED_NAT}\.{NAT}E{SIGNED_NAT}
NUMBER         {SIGNED_NAT}(\.{NAT})?(E{SIGNED_NAT})?   
   
%%
   /* specific lexer rules in regex */

"="            {printf("EQUAL\n"); currPos += yyleng; equalNum++;}
"+"            {printf("PLUS\n"); currPos += yyleng; operatorsNum++;}
"-"            {printf("MINUS\n"); currPos += yyleng; operatorsNum++;}
"*"            {printf("MULT\n"); currPos += yyleng; operatorsNum++;}
"/"            {printf("DIV\n"); currPos += yyleng; operatorsNum++;}
"("            {printf("L_PAREN\n"); currPos += yyleng; parenthesisNum++;}
")"            {printf("R_PAREN\n"); currPos += yyleng; parenthesisNum++;}
{NUMBER}       {printf("NUMBER %s\n", yytext); currPos += yyleng; integerNum++;}
[ \t]+         {/*ignore spaces*/ currPos += yyleng;}
"\n"           {currLine++; currPos = 1;}
.              {printf("Error at line %d, column %d, unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}


%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   if(argc >= 2)
   {
      yyin = fopen(argv[1], "r");
      if(yyin == NULL)
      {
         yyin = stdin;
      }
   }
   else
   {
      yyin = stdin;
   }
   yylex();
   printf("\nInteger count: %d\nOperator count: %d\nParenthesis count: %d\nEqual count: %d\n", integerNum, operatorsNum, parenthesisNum, equalNum);
}

