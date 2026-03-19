%option noyywrap
%{
	#include<stdio.h>
%}

%%
[a-z]{2}[0-9]{6}"@uaeh.edu.mx" {printf("Valido");}
%%
int main()
{
	
	return yylex();
}