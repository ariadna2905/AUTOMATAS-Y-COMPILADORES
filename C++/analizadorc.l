%option noyywrap
%{
	#include<stdio.h>
	#define TOKEN_LARGECOMMENT 1
	#define TOKEN_LINECOMMENT 2
	#define TOKEN_CADENACARACTER 3
	#define TOKEN_CARACTER 4
	#define TOKEN_FLOTANTE 5
	#define TOKEN_HEXADECIMAL 6
	#define TOKEN_BINARIO 7
	#define TOKEN_OCTAL 8
	#define TOKEN_ENTERO 9
	#define TOKEN_PALABRARESER 10
	#define TOKEN_IDENTIFICADOR 11
	#define TOKEN_OPERADOR 12
	#define TOKEN_SEPARADOR 13
%}

%%
\/\*([^*]|\*+[^*/])*\*+\/ {return TOKEN_LARGECOMMENT;}
\/\/.* {return TOKEN_LINECOMMENT;}
\"([^\\\"]|\\.)*\" {return TOKEN_CADENACARACTER;}
\'([^\\\']|\\.)\' {return TOKEN_CARACTER;}
0[xX][0-9a-fA-F]+ {return TOKEN_HEXADECIMAL;}
0[bB][01]+ {return TOKEN_BINARIO;}
0[0-7]+ {return TOKEN_OCTAL;}
[0-9]+\.[0-9]+([eE][+-]?[0-9]+)? {return TOKEN_FLOTANTE;}
[0-9]+ {return TOKEN_ENTERO;}
auto|break|case|char|class|const|continue|default|delete|do|double|else { return TOKEN_PALABRARESER; }
enum|extern|float|for|goto|if|inline|int|long|namespace|new { return TOKEN_PALABRARESER; }
operator|private|protected|public|register|return|short|signed|sizeof { return TOKEN_PALABRARESER; }
static|struct|switch|template|this|throw|try|typedef|union { return TOKEN_PALABRARESER; }
unsigned|using|virtual|void|volatile|while|bool|catch { return TOKEN_PALABRARESER; }
[a-zA-Z_][a-zA-Z0-9_]* {return TOKEN_IDENTIFICADOR;}
"<<"|">>" { return TOKEN_OPERADOR; }
"++"|"--" { return TOKEN_OPERADOR; }
"=="|"!="|"<="|">=" { return TOKEN_OPERADOR; }
"+="|"-="|"*="|"/="|"%=" { return TOKEN_OPERADOR; }
"&&"|"||" { return TOKEN_OPERADOR; }
[+\-*/%<>=!&|^~] { return TOKEN_OPERADOR; }
[()\[\]{};,.:] {return TOKEN_SEPARADOR;}
[ \t\n] ;
<<EOF>> {return 0;}
%%

int main()
{
    int token;
    
    FILE *archivo_entrada = fopen("codigo.cpp", "r");
    if (!archivo_entrada) {
        printf("Error: No se pudo abrir el archivo de entrada.\n");
        return 0;
    }
    
    FILE *archivo_salida = fopen("MyScanner.txt", "w");
    if (!archivo_salida) {
        printf("Error: No se pudo crear el archivo de salida.\n");
        return 0;
    }

    yyin = archivo_entrada;

    while((token = yylex()) != 0){
       
        if(token==TOKEN_LARGECOMMENT){
            fprintf(archivo_salida, "COMENTARIO DE BLOQUE: %s\n", yytext);
        }
        else if(token==TOKEN_LINECOMMENT){
            fprintf(archivo_salida, "COMENTARIO DE LINEA: %s\n", yytext);
        }
        else if(token==TOKEN_CADENACARACTER){
            fprintf(archivo_salida, "CADENA DE CARACTERES: %s\n", yytext);
        }
        else if(token==TOKEN_CARACTER){
            fprintf(archivo_salida, "UN CARACTER: %s\n", yytext);
        }
        else if(token==TOKEN_HEXADECIMAL){
            fprintf(archivo_salida, "NUM.HEXADECIMAL: %s\n", yytext);
        }
        else if(token==TOKEN_BINARIO){
            fprintf(archivo_salida, "NUM.BINARIO: %s\n", yytext);
        }
        else if(token==TOKEN_OCTAL){
            fprintf(archivo_salida, "NUM.OCTAL: %s\n", yytext);
        }
        else if(token==TOKEN_FLOTANTE){
            fprintf(archivo_salida, "NUM.FLOTANTE: %s\n", yytext);
        }
        else if(token==TOKEN_ENTERO){
            fprintf(archivo_salida, "NUM.ENTERO: %s\n", yytext);
        }
        else if(token==TOKEN_PALABRARESER){
            fprintf(archivo_salida, "PALABRAS RESERVADAS: %s\n", yytext);
        }
        else if(token==TOKEN_IDENTIFICADOR){
            fprintf(archivo_salida, "UN IDENTIFICADOR: %s\n", yytext);
        }
        else if(token==TOKEN_OPERADOR){
            fprintf(archivo_salida, "OPERADORES: %s\n", yytext);
        }
        else if(token==TOKEN_SEPARADOR){
            fprintf(archivo_salida, "SEPARADOR: %s\n", yytext);
        }
    }

    fclose(archivo_entrada);
    fclose(archivo_salida);
    printf("Analisis completado. Resultados guardados en 'MyScanner.txt'\n");

    return 0;
}