#include <iostream>

/* 
   Este es un comentario de bloque extenso
   para verificar que Flex lo reconoce correctamente.
*/

// Comentario de una sola linea

using namespace std;

int main() {
    //TOKEN_CADENACARACTER
    char* saludo = "Hola, esto es una cadena con \"escape\""; 
    
    // TOKEN_CARACTER
    char letra = 'Z'; 
    char escape = '\n';

    // TOKEN_FLOTANTE
    float pi = 3.14159;
    double expo = 2.5e-10; 
    int hex = 0xABC123;
    int bin = 0b10101011;
    int octal = 0755;
    int normal = 123456789;

    bool condicion = true;
    if (condicion) {
        double valor = 0.0;
        static int contador = 0;
        unsigned long largo = 1000;
    }

    int a = 10, b = 20;
    int c = (a + b) * (b / a) % 2; 
    bool res = (a == b) || (a != b) && (a <= b) || (a >> 1) << 2;
    a += 5; 
    b--;
    a++;

    int arreglo[] = {1, 2, 3}; // [ ] { } , ;
    float decimal = 10.5;      // . y :


    return 0; 
}