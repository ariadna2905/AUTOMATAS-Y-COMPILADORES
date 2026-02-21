#include <iostream>
#include <regex>
#include <fstream>
#include <string>

using namespace std;

bool esRFC(string texto) {
    regex regla("^([A-Z&Ñ]{4}[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])[A-Z0-9]{3})+$");
    return regex_match(texto, regla);
}

bool esCURP(string texto) {
    regex regla("^([A-Z]{4}(0[1-9]|1[0-2])(0[1-9]|[12]|3[01])[HM][A-Z]{2}[A-Z0-9]{3})+$");
    return regex_match(texto, regla);
}

bool esINE(string texto) {
    regex regla("^([A-Z]{6}(0[1-9]|1[0-2])(0[1-9]|[12]|3[01])[A-Z]{2}[HM][0-9]{3})+$");
    return regex_match(texto, regla);
}

ifstream lectura() {
    ifstream archivo("RFC,CURP,INE.txt", ios::in);//colocar el nombre de su archivo profe dentro de la misma carpeta que el codigo
    if(archivo.fail()) {
        cout << "No se pudo abrir el archivo de lectura" << endl;
        exit(1);
    }
    return archivo;
}

int main() {
    ifstream miArchivo = lectura();
    ofstream archivoSalida("resultado_analisis.txt", ios::out);

    if(archivoSalida.fail()) {
        cout << "No se pudo crear el archivo de salida" << endl;
        return 1;
    }

    string linea;
    string resultado;

    while(getline(miArchivo, linea)) {
        if(linea.empty()) continue;

        if (esRFC(linea)) {
            resultado = "[RFC VALIDO]:  " + linea;
        } 
        else if (esCURP(linea)) {
            resultado = "[CURP VALIDO]: " + linea;
        } 
        else if (esINE(linea)) {
            resultado = "[INE VALIDO]:  " + linea;
        } 
        else {
            resultado = "[INVALIDO]:    " + linea;
        }
        cout << resultado << endl;
        archivoSalida << resultado << endl;
    }

    cout << "\n--- Analisis finalizado. Resultados guardados en 'resultado_analisis.txt' ---" << endl;

    miArchivo.close();
    archivoSalida.close();
    
    return 0;
}