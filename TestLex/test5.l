%option noyywrap
%{
	#include<stdio.h>
%}

%%
[A-Z]{4}[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])[HM][A-Z]{2}[A-Z0-9]{5} {printf("Valido");}
%%

int main()
{
	return yylex();
}