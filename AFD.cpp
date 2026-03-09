#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int main() {

    int N, S, D, q0, T, C;
    cout << "Ingrese el numero de estados (N): ";
    cin >> N;
    cout << "Ingrese la cantidad de simbolos del alfabeto (S): ";
    cin >> S;
    cout << "Ingrese el numero de transiciones (D): ";
    cin >> D;
    cout << "Ingrese el estado inicial (q0): ";
    cin >> q0;
    cout << "Ingrese la cantidad de estados de aceptacion (T): ";
    cin >> T;
    cout << "Ingrese la cantidad de cadenas a evaluar (C): ";
    cin >> C;
    cout<<"\n\n";
    char alfabeto[10];
    for (int i = 0; i < S; i++) {
        char simbolo;
        cout << "Ingrese alfabeto " << i + 1 << " de " << S << ": ";
        cin >> simbolo;
        while (!isalpha(simbolo) && !isdigit(simbolo)) {
            cout << "ERROR: Solo se permiten letras o numeros.\n";
            cout << "Ingrese nuevamente alfabeto " << i + 1 << ": ";
            cin >> simbolo;
        }
        alfabeto[i] = simbolo;
    }

    int aceptacion[3];
    for (int i = 0; i < T; i++) {
        cout << "Ingrese estado de aceptacion " << i + 1 << " de " << T << ": ";
        cin >> aceptacion[i];
    }

    cout << "Formato: Primero Ingresar Origen luego el simbolo que entra y por ultimo el destino al que lleva\n";
    cout << "Debe ingresar " << D << " transiciones\n";
    int origen[15];
    char simbolo[15];
    int destino[15];
    for (int i = 0; i < D; i++) {
        cout << "Transicion " << i + 1 << " de " << D << ": ";
        cin >> origen[i] >> simbolo[i] >> destino[i];
    }

   string cadenas[10];
    for (int i = 0; i < C; i++) {
        cout << "Ingrese cadena " << i + 1 << " de " << C << ": ";
        cin >> cadenas[i];
    }
    
    cout << "\n--- RESULTADOS ---\n";
    for (int i = 0; i < C; i++) {
        int estadoActual = q0;
        for (int j = 0; j < cadenas[i].length(); j++) {
            char letra = cadenas[i][j];
            for (int k = 0; k < D; k++) {
                if (origen[k] == estadoActual && simbolo[k] == letra) {
                    estadoActual = destino[k];
                    break;
                }
            }
        }
        bool aceptada = false;
        for (int j = 0; j < T; j++) {
            if (estadoActual == aceptacion[j]) {
                aceptada = true;
            }
        }
        cout << "Cadena \"" << cadenas[i] << "\" -> ";
        if (aceptada) {
            cout << "ACEPTADA\n";
        } else {
            cout << "RECHAZADA\n";
        }
    }

    return 0;
}
//PALMA VELAZQUEZ ARIADNA BETSABE :)