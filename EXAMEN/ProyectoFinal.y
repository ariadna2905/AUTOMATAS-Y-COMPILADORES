%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(const char *s);
int yylex(void);
%}

%union {
    char *select;
    char *from;
    char *where;
    char *and;
    char *or;
    char *insert;
    char *into;
    char *values;
    char *update;
    char *set;
    char *delete;
    char *id;
    char *number;
    char *string;
    char *start;
    char *comma;
    char *puntoycoma;
    char *eq;
    char *lt;
    char *gt;
    char *l;
    char *r;
}

%type <string> value
%token <select> SELECT 
%token <from> FROM 
%token <where> WHERE 
%token <and> AND 
%token <or> OR
%token <insert> INSERT 
%token <into> INTO 
%token <values> VALUES
%token <update> UPDATE 
%token <set> SET
%token <delete> DELETE
%token <id> ID 
%token <number> NUMBER 
%token <string> STRING
%token <start> STAR 
%token <comma> COMMA 
%token <puntoycoma> PUNTOYCOMA
%token <eq> EQ 
%token <lt> LT 
%token <gt> GT
%token <l> LPAREN 
%token <r> RPAREN
%token ENDLINE

%%

input:
    | input line
    ;

line:
    ENDLINE 
    | query PUNTOYCOMA ENDLINE { printf(" ESTADO: SENTENCIA SQL VALIDA\n\n"); }
    | query ENDLINE { printf("ERROR FALTA PUNTO Y COMA\n\n"); }
    | error ENDLINE { yyerrok; printf("ANILIZADOR RECUPERADO\n\n"); }
    ;

query:
    select_query { printf("OPERACION: Consulta (SELECT)\n"); }
    | insert_query { printf("OPERACION: Insercion (INSERT)\n"); }
    | update_query { printf("OPERACION: Actualizacion (UPDATE)\n"); }
    | delete_query { printf("OPERACION: Eliminacion (DELETE)\n"); }
    ;

select_query:
    SELECT select_list FROM table_list where_clause 
    ;

select_list:
    STAR { printf("  COLUMNA: [TODAS] (*)\n"); }
    | column_list
    ;

insert_query:
    INSERT INTO ID { printf("  TABLA DESTINO: %s\n", $3); } opt_column_list VALUES LPAREN value_list RPAREN
    ;

opt_column_list:
    | LPAREN column_list RPAREN
    ;

value_list:
    value
    | value_list COMMA value
    ;

value:
    NUMBER { printf("  VALOR NUMERICO: %s\n", $1);$$ = $1; }
    | STRING { printf("  VALOR TEXTO: %s\n", $1);$$ = $1; }
    ;

update_query:
    UPDATE ID { printf("  ACTUALIZANDO TABLA: %s\n", $2); } SET assignment_list where_clause
    ;

assignment_list:
    assignment
    | assignment_list COMMA assignment
    ;

assignment:
    ID EQ value { printf("  ASIGNACION: %s = %s\n", $1, $3); }
    ;

delete_query:
    DELETE FROM ID { printf(" BORRANDO DE TABLA: %s\n", $3); } where_clause
    ;

column_list:
    ID { printf("  COLUMNA: %s\n", $1); }
    | column_list COMMA ID { printf("  COLUMNA: %s\n", $3); }
    ;

table_list:
    ID { printf("  TABLA: %s\n", $1); }
    | table_list COMMA ID { printf("  TABLA: %s\n", $3); }
    ;

where_clause:
    | WHERE { printf("  CLAUSULA: WHERE DETECTADO\n"); } condition
    ;

condition:
    expr
    | condition AND { printf("  LOGICA: AND\n"); } expr
    | condition OR { printf("  LOGICA: OR\n"); } expr
    ;

expr:
    ID EQ ID      { printf("  CONDICION: %s = %s\n", $1, $3); }
    | ID EQ value { printf("  CONDICION: %s = %s\n", $1, $3); }
    | ID LT NUMBER { printf("  CONDICION: %s < %s\n", $1, $3); }
    | ID GT NUMBER { printf("  CONDICION: %s > %s\n", $1, $3); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "ERROR DE SINTAXIS: %s\n", s);
}

int main(void) {

    printf("Escribe tus sentencias SQL: \n");
    yyparse();
    return 0;
}