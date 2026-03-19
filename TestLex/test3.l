%option noyywrap
%{
	#include<stdio.h>
%}

%%
[a-z][a-z][_}[0-9]* {printf("Variable \n");}
%%
int main()
{

	return yylex();
}