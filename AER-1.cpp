#include <iostream>
#include <string>
#include <cctype>

using namespace std;

bool esEntero(string s) {
    if (s.empty()) return false;
    for (char c : s) {
        if (!isdigit(c)) return false;
    }
    return true;
}

bool esMinuscula(string s) {
    if (s.empty()) return false;
    for (char c : s) {
        if (!islower(c)) return false;
    }
    return true;
}

bool esMayuscula(string s) {
    if (s.empty()) return false;
    for (char c : s) {
        if (!isupper(c)) return false;
    }
    return true;
}

bool esIdentificador(string s) {
    if (s.empty() || isdigit(s[0])) return false;

    for (char c : s) {
        if (isspace(c)) {
            return false;
        }
        if (!isalnum(c) && c != '_') {
            return false;
        }
    }
    return true;
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
        cout << "Es un Identificador valido." << endl;
    } 
    else {
        cout << "Error!!" << endl;
    }

    return 0;
}

//PALMA VELAZQUEZ ARIADNA BETSABE :)