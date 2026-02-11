#include <iostream>
#include <string>
#include <regex>
#include <cctype>

using namespace std;

bool esEntero(string s) {
    const regex expReg("^[0-9]+$");
    return regex_match(s, expReg);
}

bool esMinuscula(string s) {
    const regex expReg("^[a-z\\s]+$");
    return regex_match(s, expReg);
}

bool esMayuscula(string s) {
    const regex expReg("^[A-Z\\s]+$");
    return regex_match(s, expReg);
}

bool esIdentificador(string s) {
    const regex expReg("^[a-zA-Z]+[0-9\\_]+$");
    return regex_match(s, expReg);
}

bool esSimbolos(string s) {
    const regex expReg("^[^a-zA-Z0-9]+$");
    return regex_match(s, expReg);
}

int main() {
    string entrada;
    cout << "Ingrese una cadena de simbolos: ";
    getline(cin, entrada);

    cout << "\nAnalisis de la cadena: " << endl;
    
    if (esEntero(entrada)) {
        cout << "Es un Numero Entero." << endl;
    } 
    else if (esMinuscula(entrada)) {
        cout << "Es una palabra en Minusculas." << endl;
    } 
    else if (esMayuscula(entrada)) {
        cout << "Es una palabra en Mayusculas." << endl;
    } 
    else if (esIdentificador(entrada)) {
        cout << "Es una Variable valida." << endl;
    } 
    else if (esSimbolos(entrada)) {
        cout << "Es un Simbolo valido." << endl;
    } 
    else {
        cout << "Error!!" << endl;
    }

    return 0;
}

//PALMA VELAZQUEZ ARIADNA BETSABE :)