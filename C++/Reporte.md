# **REPORTE PRACTICA 2.5** 
## *ANALIZADOR DE C++ EN LEX* 
### Palma Velazquez Ariadna Betsabe 6-3


## **_Introducción_**
En el siguiente documento se muestra el proceso que se llevo acabo para realizar el desarrollo de de un analizador lexico para el el lenguaje de programacion C++,
en el cual se tiene que identificar las partes que componen un codigo; es decir, las palabras reservadas, cuales son separadores, identificadores, enteros y otros mas 
componentes que diferencian a un codigo en C++ con otros lenguajes. Este analizador ayuda tambien para conocer de una forma mas fisica y no tan teorica de como es que 
funcionan los compiladores de est lenguaje para indicarle a los usuarios y esta correcto o no el codigo, al analizar los tokens que se generan en el codigo.


## **_Objetivos_**
- Distinguir token, lexema y patrón en código C++
- Escribir expresiones regulares (ER) para cada categoría léxica
- Desarrollar codigo en FLEX/LEX


## **_Dessarrollo_**
### _Categorias de Tokens_
- Palabras reservadas del LP
- Identificadores (variables)
- Números enteros
- Números flotantes, hexadecimales, binarios y octales
- Cadenas de carácteres
- Caracteres
- Operadores
- Separadores
- Comentarios de una lìnea
- Bloque de comentarios

### _Creación de expresiones regulares_ 
- Palabras reservadas del LP : **auto|break|case|char|class|const|continue|default|delete|do|double|else|enum|extern|float|for|goto|if|inline|int|long|
namespace|new|operator|private|protected|public|register|return|short|signed|sizeof|static|struct|switch|template|this|throw|try|typedef|union 
unsigned|using|virtual|void|volatile|while|bool|catch** 

- Identificadores (variables) : **[a-zA-Z_][a-zA-Z0-9_]***
  
- Números enteros : **[0-9]+**
  
- Números flotantes : **[0-9]+\.[0-9]+([eE][+-]?[0-9]+)?**
  
- Numeros hexadecimales : **0[xX][0-9a-fA-F]+**
  
- Numeros binarios : **0[bB][01]+**
  
- Numeros octales : **0[0-7]+**
  
- Cadenas de carácteres: **\"([^\\\"]|\\.)*\"**
  
- Caracteres : **\'([^\\\']|\\.)\'**
  
- Operadores : **"<<"|">>"|"++"|"--"|"=="|"!="|"<="|">=" |"+="|"-="|"*="|"/="|"%="|"&&"|"||" |[+\-*/%<>=!&|^~]**
  
- Separadores : **[()\[\]{};,.:]**
  
- Comentarios de una lìnea : **\/\/.***
  
- Bloque de comentarios : **\/\*([^*]|\*+[^*/])*\*+\/**


### _Clasificación en orden de gerarquia de los tokens_
- Bloques de comentarios
- Linea de comentario
- Cadena de Caracteres
- Caracter
- Hexagecimal
- Binario
- Octal
- Flotantes
- Enteros
- Palabras Reservadas
- Identificador
- Operador
- Separadores


### _Primer bloque de codigo_
En esta primea parte del codigo se definieron las variables que se utilizarian para guardar los tokens de cada lexema presentado en el codigo dentro de su archivo
cpp; para despues ser utilizadas en el main, durante el proceso de analisis de los patrones. 

<pre>
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
</pre>

### _Segundo bloque de codigo_
En esta sección se acomodaron las reglas en su orden gerarquico para que a la hora de compilar y anlizar el archivo cpp, no se salte ninguna de las reglas
o haga falta contemplar alguna de las reglas porque tuvo mayor importancia la anterior y tambien entra el token en esa aunque no sea la correcta.
Tambien en este pedazo del codigo se presentaron varias dificultades, como lo fue que al colocar en una sola regla en recorrido la parte de **operadores**
no la leia correctamente asi que se tuvo que dividir la regla en 5 reglas mas pequeñas asi como se tuvo que colocar entre comillas algunos de los simbolos
para que fueran leidos correctamente; el que se haya dividido la regla no significa que se devieron de definir mas variables para ese patron, se pudo guardar
en esa misma variable. 
Tambien paso algo similar con la regla de palabras reservadas al ser demasiado extensa la regla nos marcaba un error de lectura, asi que tambien se tuvo
que dicidir la regla, para que no hubiera proble de lectura.

<pre>
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
</pre>
**NOTA** : Algo importante que hay que destacar en esta parte es que si no colocaba las siglas de **EOF** al final de las reglas indicando que esto solo se aplica al 
return el codigo al compilarlo se ciclaba de forma infinita y no funcionaba ni llegaba a nada el analizador: Investigando esto sucedia porque el while no era
suficiente para indicar bien cuando terminaba nueatra lectura del archivo. 

### -Ultimo bloque de codigo_ 
En este ultimo apartadxo es el main; donde se colocan los if para indicar como se va ir llamando he imprimiendo los resultado.Asi como se indica que el codigo solo
funciona si se manda un archivo cpp con el nombre codigo y al final debe de generar un archivo txt con el resultado del analizador.

<pre>
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
</pre>
