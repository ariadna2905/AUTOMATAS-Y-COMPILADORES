%{
	#include <stdio.h>
	#include <stdlib.h>
	extern int yylex(void);
	extern int yyerror(const char *s);
	extern FILE *yyin; 
%}

%union{
int entero;
int bina;
int octa;
float flota;
char* variable;
char* comparar;
char* largo;
char* linea;
char* cadena;
char* hexa;
char* palabra;
char* operador;
}

%token <entero> TOKEN_ENTERO
%token <bina> TOKEN_BINARIO
%token <octa> TOKEN_OCTAL
%token <flota> TOKEN_FLOTANTE
%token <variable> TOKEN_IDENTIFICADOR
%token <comparar> TOKEN_COMPARADOR
%token <largo> TOKEN_LARGECOMMENT
%token <linea> TOKEN_LINECOMMENT
%token <cadena> TOKEN_CADENACARACTER
%token <hexa> TOKEN_HEXADECIMAL
%token <palabra> TOKEN_PALABRARESER
%token <operador> TOKEN_OPERADOR
%token TOKEN_CARACTER TOKEN_SEPARADOR EOL

%left TOKEN_COMPARADOR
%left TOKEN_OPERADOR

%type <flota> expresion valor

%% 

input:
     | input linea
     ;

linea:
     expresion EOL { printf("--EXPRESION VALIDA\n\n"); }
     | TOKEN_LINECOMMENT EOL { printf("--COMENTARIO DE LINEA: %s\n", $1); }
     | TOKEN_LARGECOMMENT EOL { printf("--COMENTARIO MULTILINEA: %s\n", $1); }
     | error EOL { yyerrok; }
     | EOL
     ;

expresion:
    valor { $$ = $1; }
    | expresion TOKEN_OPERADOR expresion { printf("--OPERADOR: %s\n", $2); }
    | expresion TOKEN_COMPARADOR expresion { printf("--COMPARADOR: %s\n", $2); }
    | expresion TOKEN_SEPARADOR { printf("--SEPARADOR:\n"); }
    | TOKEN_PALABRARESER expresion { printf("--PALABRA RESERVADA: %s\n", $1); }
    | '(' expresion ')' { printf("--PARENTESIS:\n"); $$ = $2; }
    ;

valor:
    TOKEN_ENTERO { printf("--ENTERO: %d\n", $1); $$ = (float)$1; }
    | TOKEN_FLOTANTE { printf("--FLOTANTE: %f\n", $1); $$ = $1; }
    | TOKEN_BINARIO { printf("--BINARIO: %f\n", $1); $$ = (float)$1; }
    | TOKEN_OCTAL { printf("--OCTAL: %f\n",$1); $$ = (float)$1; }
    | TOKEN_HEXADECIMAL { printf("--HEXADECIMAL: %s\n", $1); $$ = 0; }
    | TOKEN_IDENTIFICADOR { printf("--IDENTIFICADOR: %s\n", $1); $$ = 0; }
    | TOKEN_CADENACARACTER { printf("--CADENA DE CARACTERES: %s\n", $1); $$ = 0; }
    | TOKEN_CARACTER { printf("--CARACTER\n"); $$ = 0; }
    ;

%%

int main() {
    FILE *archivo_entrada = fopen("entrada.txt", "r");
    if (!archivo_entrada) {
        printf("Error: No se pudo abrir entrada.txt\n");
        return 1;
    }

    if (freopen("salida.txt", "w", stdout) == NULL) {
        printf("Error: No se pudo crear salida.txt\n");
        fclose(archivo_entrada);
        return 1;
    }

    yyin = archivo_entrada;
    yyparse();
    fclose(archivo_entrada);
    return 0;
} 

int yyerror(const char *s) {
    printf("-- EXPRESION INVALIDA\n\n");
    return 0;
}
