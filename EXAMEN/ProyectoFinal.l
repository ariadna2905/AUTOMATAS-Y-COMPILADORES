%option noyywrap
%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
%}

%option case-insensitive

%%

\r\n|\n                      { return ENDLINE; }
[ \t]+                  { /* Ignorar solo espacios y tabulaciones */ }
"SELECT"                {yylval.select = strdup(yytext); return SELECT; }
"FROM"                  {yylval.from = strdup(yytext); return FROM; }
"WHERE"                 {yylval.where = strdup(yytext); return WHERE; }
"AND"                   {yylval.and = strdup(yytext); return AND; }
"OR"                    {yylval.or = strdup(yytext); return OR; }
"INSERT"                {yylval.insert = strdup(yytext); return INSERT; }
"INTO"                  {yylval.into = strdup(yytext); return INTO; }
"VALUES"                {yylval.values = strdup(yytext); return VALUES; }
"UPDATE"                {yylval.update = strdup(yytext); return UPDATE; }
"SET"                   {yylval.set = strdup(yytext); return SET; }
"DELETE"                {yylval.delete = strdup(yytext); return DELETE; }
[a-zA-Z][a-zA-Z0-9_]*   {yylval.id = strdup(yytext); return ID; }
[0-9]+                  {yylval.number = strdup(yytext); return NUMBER; }
'[^']*'                 {yylval.string = strdup(yytext); return STRING; }
"*"                     {yylval.start = strdup(yytext); return STAR; }
","                     {yylval.comma = strdup(yytext); return COMMA; }
";"                     {yylval.puntoycoma = strdup(yytext); return PUNTOYCOMA; }
"="                     {yylval.eq = strdup(yytext); return EQ; }
"<"                     {yylval.lt = strdup(yytext); return LT; }
">"                     {yylval.gt = strdup(yytext); return GT; }
"("                     {yylval.l = strdup(yytext); return LPAREN; }
")"                     {yylval.r = strdup(yytext); return RPAREN; }

%%