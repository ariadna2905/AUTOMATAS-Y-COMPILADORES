%{
	#include<stdio.h>
	int yylex(void);
	int yyerror(const char *s);
%}

%union{
int valor_entero;
float valor_decimal;
char* variable;
char* condicional;
}
%token <valor_entero> ENTERO
%token <valor_decimal> DECIMAL
%token <condicional> COMPARA
%token <variable> IDENTI
%token SUMA RESTA MULTI DIVI PARENA PARENC EOL

%left SUMA RESTA
%left MULTI DIVI

%type <valor_decimal> expression

%% 

statements : statement statements
	   | statement
	   ;
statement  : expression EOL {printf("-> EXPRESION ARITMETICA VALIDA\n\n");}
	   | expression COMPARA expression EOL {printf("op_condicinal -> %s\n -> EXPRESION CONDICIONAL VALIDA \n\n", $2);}
	   | error EOL      { yyerrok;}
	   | EOL            { }
	   ;


expression : ENTERO {$$=$1; printf("entero -> %d\n",(int)$$);}
	   | DECIMAL {$$=$1; printf("decimal -> %f\n",$$);}
	   | IDENTI { $$=0.0; printf("identificador -> %s\n",$1);}
	   | expression SUMA expression {$$=$1+$3; printf("suma -> +\n Resultado:%f\n", $$);}
	   | expression RESTA expression {$$=$1-$3; printf("resta -> -\n Resultado:%f\n", $$);}
	   | expression MULTI expression {$$=$1*$3; printf("multiplicacion-> * \n Resultado:%f\n", $$);}
	   | expression DIVI expression {if ($3 == 0.0) {
                    printf("-> Error matematico: Division por cero\n");
                    $$ = 0.0;
                } else {
                    $$ = $1/$3; printf("division -> / \n Resultado:%f\n", $$); 
                }
             }
	   | PARENA expression PARENC   { $$ = $2; printf("paren_abre -> (\n paren_cierre -> )\n");}
	   ;
%%

int main(){
yyparse();
return 0;
}
int yyerror(const char *s) {
    printf("-> EXPRESION INVALIDA\n\n");
    return 0;
}