%option noyywrap
%{
	#include<stdio.h>
%}

%%
[0-9]+ {printf("Numero Entero ");}
%%
int main()
{
	
	return yylex();
}