## Analizador Semántico
### Teoría
El análisis semántico es la fase del compilador encargada de verificar que el programa fuente cumpla con las reglas de coherencia del lenguaje que no pueden ser verificadas mediante gramáticas libres de contexto. Su propósito principal es garantizar que las operaciones descritas tengan significado computacional.

Mientras el analizador sintáctico asegura que una expresión tenga la forma A = B + C, el analizador semántico responde a las preguntas críticas: ¿Fueron A, B y C declaradas previamente? ¿El tipo de dato de B es compatible para sumarse con C? ¿Es A una variable modificable (l-value) o es una constante? La teoría central de esta fase se basa en el Sistema de Tipos y las reglas de alcance (Scope), garantizando un estado seguro antes de pasar a la generación de código intermedio.

### Herramientas y Técnicas
Para llevar a cabo su tarea, el analizador semántico se apoya en modelos matemáticos y estructuras de datos rigurosas:
- **Tabla de Símbolos:** Es la estructura de datos vital del compilador. Almacena todos los identificadores (variables, funciones, arreglos) encontrados, registrando sus atributos fundamentales como el tipo de dato, el ámbito de visibilidad (scope) y el espacio de memoria que ocuparán.
- **Traducción Dirigida por la Sintaxis (TDS):** Es una técnica donde se asocian "acciones semánticas" directamente a las reglas de producción de la gramática. Al momento de reducir una regla sintáctica, se ejecuta un fragmento de código que realiza comprobaciones semánticas.
- **Árbol de Sintaxis Abstracta (AST):** Representación jerárquica y condensada del código fuente. A diferencia del árbol de derivación (parse tree), el AST omite detalles sintácticos irrelevantes (como llaves o paréntesis) y mantiene solo la esencia de las operaciones.

### Manejo de Errores

El analizador semántico es el juez más estricto del compilador. Un buen diseño no debe detenerse en el primer error, sino registrarlo, emitir un mensaje descriptivo con la línea exacta y recuperarse para seguir analizando. Los errores que captura y maneja incluyen:

- **Variables no declaradas:** Uso de un identificador que no existe en el ámbito actual de la Tabla de Símbolos.
- **Múltiples declaraciones:** Intentar declarar la misma variable dos veces en el mismo ámbito.
- **Incompatibilidad de tipos (Type Mismatch):** Asignar un valor flotante a un entero de manera insegura, o intentar sumar un booleano con un caracter sin reglas de coerción explícitas.
- **Inconsistencia en llamadas a funciones:** Pasar más o menos parámetros de los esperados, o con tipos incorrectos respecto a la firma de la función.

### ¿Cómo se construye?

La construcción de un analizador semántico robusto suele seguir una arquitectura de "recorrido de árboles". El proceso paso a paso es el siguiente:

1. **Recepción:** Recibe el Árbol de Sintaxis Abstracta (AST) generado por la fase sintáctica.
2. **Población de la Tabla:** En un primer recorrido (o durante la misma fase sintáctica), se puebla la Tabla de Símbolos con todas las declaraciones (variables y funciones) para definir los alcances.
3. **Recorrido y Decoración:** Se realiza un recorrido del AST (usualmente en post-orden, evaluando primero los nodos hijos para poder evaluar a los padres). Durante este recorrido, se "decoran" los nodos. Esto significa agregar atributos a los nodos del árbol, como el tipo de dato resultante de una expresión.
4. **Validación:** Al evaluar un nodo de operación (ej. un nodo suma), se extraen los tipos de sus nodos hijos, se aplican las reglas de inferencia de tipos y se verifica la compatibilidad. Si hay un conflicto, se dispara la rutina de manejo de errores.

### Referencias

- Aho, A. V., Lam, M. S., Sethi, R., & Ullman, J. D. (2008). Compiladores: Principios, técnicas y herramientas (2a ed.). Pearson Educación.
- Louden, K. C. (2004). Construcción de compiladores: Principios y práctica. Thomson. 

### Cuestionario
https://docs.google.com/forms/d/e/1FAIpQLSejF8Zgb2b7CXiHNgm9KSgWEgrftJnLjA-yqxSVEGlMsuTEOw/viewform?usp=dialog

### Resultados del cuestionario
<img width="702" height="1600" alt="image" src="https://github.com/user-attachments/assets/54d1572a-08ab-418e-9e0a-4210bcf97b54" />
<img width="1600" height="756" alt="image" src="https://github.com/user-attachments/assets/1a6ff9a0-7c47-4053-b8fa-457377d08626" />
<img width="1600" height="770" alt="image" src="https://github.com/user-attachments/assets/1461516a-1740-49f2-8731-59e694ea2b38" />


