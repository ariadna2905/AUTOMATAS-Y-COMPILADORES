%{
    #include <stdio.h>
    #include <string.h>
    #include "y.tab.h" 
%}

%%
[0-9]+                  { yylval.valor_entero = atoi(yytext); return ENTERO; }
[0-9]*\.[0-9]+          { yylval.valor_decimal = atof(yytext); return DECIMAL; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.variable = strdup(yytext); return IDENTI; }
"\+"                    { return SUMA; }
"-"                     { return RESTA; }
"\*"                    { return MULTI; }
"/"                     { return DIVI; }
"\("                    { return PARENA; }
"\)"                    { return PARENC; }
"=="|"!="|"<="|">="|"<"|">" { yylval.condicional = strdup(yytext);return COMPARA; }
\n {return EOL;}
[ \t]                   { /* Ignorar espacios y tabuladores */ }
%%

int yywrap(void){return 1;}