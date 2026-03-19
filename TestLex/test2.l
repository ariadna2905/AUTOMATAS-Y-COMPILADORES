%option noyywrap
%{
	#include<stdio.h>
%}

%%
[0-9]*"."[0-9]+ {printf("Numeros Decimales \n");}
%%
int main()
{
	
	return yylex();
}