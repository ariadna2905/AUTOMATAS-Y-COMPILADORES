%option noyywrap
%{
	#include<stdio.h>
	#include <string.h>
	#include "y.tab.h" 
%}

%%
\/\*([^*]|\*+[^*/])*\*+\/ { yylval.largo = strdup(yytext);return TOKEN_LARGECOMMENT;}
\/\/.* { yylval.linea = strdup(yytext);return TOKEN_LINECOMMENT;}
\"([^\\\"]|\\.)*\" { yylval.cadena = strdup(yytext);return TOKEN_CADENACARACTER;}
\'([^\\\']|\\.)\' {return TOKEN_CARACTER;}
0[xX][0-9a-fA-F]+ { yylval.hexa = strdup(yytext);return TOKEN_HEXADECIMAL;}
0[bB][01]+ {yylval.bina = (int)strtol(yytext+2, NULL, 2);return TOKEN_BINARIO;}
0[0-7]+ {yylval.octa = (int)strtol(yytext, NULL, 8);return TOKEN_OCTAL;}
[0-9]+\.[0-9]+([eE][+-]?[0-9]+)? {yylval.flota = atof(yytext);return TOKEN_FLOTANTE;}
[0-9]+ {yylval.entero = atoi(yytext);return TOKEN_ENTERO;}
auto|break|case|char|class|const|continue|default|delete|do|double|else { yylval.palabra = strdup(yytext);return TOKEN_PALABRARESER; }
enum|extern|float|for|goto|if|inline|int|long|namespace|new { yylval.palabra = strdup(yytext);return TOKEN_PALABRARESER; }
operator|private|protected|public|register|return|short|signed|sizeof { return TOKEN_PALABRARESER; }
static|struct|switch|template|this|throw|try|typedef|union { yylval.palabra = strdup(yytext);return TOKEN_PALABRARESER; }
unsigned|using|virtual|void|volatile|while|bool|catch {yylval.palabra = strdup(yytext);return TOKEN_PALABRARESER; }
[a-zA-Z_][a-zA-Z0-9_]* {yylval.variable = strdup(yytext);return TOKEN_IDENTIFICADOR;}
"<<"|">>" { yylval.operador = strdup(yytext);return TOKEN_OPERADOR; }
"++"|"--" { yylval.operador = strdup(yytext);return TOKEN_OPERADOR; }
"=="|"!="|"<="|">=" {yylval.comparar = strdup(yytext); return TOKEN_COMPARADOR; }
"+="|"-="|"*="|"/="|"%=" { yylval.operador = strdup(yytext);return TOKEN_OPERADOR; }
"&&"|"||" { yylval.operador = strdup(yytext);return TOKEN_OPERADOR; }
[+\-*/%<>=!&|^~] { yylval.operador = strdup(yytext);return TOKEN_OPERADOR; }
[()\[\]{};,.:] {return TOKEN_SEPARADOR;}
\n {return EOL;}
[ \t\n] ;
%%

