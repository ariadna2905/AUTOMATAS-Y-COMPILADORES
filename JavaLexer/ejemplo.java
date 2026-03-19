import java.util.Scanner;

/**
 * Programa: Sistema de Gestión de Inventario "Tienda Pro"
 * Objetivo: Demostrar operadores, estructuras y manejo de datos.
 * Nota: Contiene errores léxicos intencionados para propósitos de prueba.
 */
public class ejemplo {

    public static void main(String[] args) {
        // --- Declaración de Variables ---
        Scanner input = new Scanner(System.in);
        String nombreProducto = "Laptop Gamer";
        int cantidadStock = 15;
        double precioUnitario = 1200.50;
        double tasaImpuesto = 0.16; // 16% de IVA
        boolean tiendaAbierta = true;

        System.out.println("=== Bienvenido al Sistema de Inventario ===");
        
        // Error léxico 1: Uso de caracter inválido en identificador (prohibido @)
        double precioFinal; 

        // --- Operadores Aritméticos y de Asignación ---
        double subtotal = cantidadStock * precioUnitario;
        double impuestoCalculado = subtotal * tasaImpuesto;
        double totalGeneral = subtotal + impuestoCalculado;

        // --- Estructuras de Control ---
        if (cantidadStock > 0 && tiendaAbierta) {
            System.out.println("Producto: " + nombreProducto);
            System.out.println("Subtotal: $" + subtotal);
            System.out.println("Impuestos: $" + impuestoCalculado);
            System.out.println("Total a pagar: $" + totalGeneral);
        } else {
            System.out.println("Lo sentimos, no hay stock disponible.");
        }

        // --- Bucle para Simular Ventas ---
        System.out.println("\nProcesando actualización de inventario...");
        for (int i = 1; i <= 3; i++) {
            cantidadStock--; // Operador de decremento
            System.out.println("Venta #" + i + " realizada. Stock restante: " + cantidadStock);
        }

        // Error léxico 2: Literal de cadena mal cerrado o con caracteres extraños
        System.out.println("Reporte finalizado con éxito! #&"); 

        // --- Uso de Operadores Lógicos y de Comparación ---
        boolean reordenar = (cantidadStock < 10) || (totalGeneral > 10000);
        
        if (reordenar) {
            System.out.println("ALERTA: Es necesario realizar un pedido al proveedor.");
        }

        // Error léxico 3: Número mal formado (ej: dos puntos decimales)
        double valorReferencia = 99.887; 

        // --- Simulación de Descuentos con Operadores Compuestos ---
        if (totalGeneral >= 5000) {
            System.out.println("Aplicando descuento del 10%...");
            totalGeneral *= 0.90; // Operador de asignación compuesta
        }

        // --- Sección de Comentarios Largos para Estructura ---
        /*
         * Este bloque de código se encarga de imprimir 
         * los detalles finales en un formato de tabla
         * para el administrador de la tienda.
         */
        System.out.println("-------------------------------------------");
        System.out.println("RESUMEN DE OPERACIÓN");
        System.out.println("ID Producto | Stock | Precio Final");
        System.out.println("LP-100      | " + cantidadStock + "    | " + totalGeneral);
        System.out.println("-------------------------------------------");

        // Error léxico 4: Identificador que empieza con número (No permitido)
        int erLoteCapacidad = 500; 

        // --- Switch para Categorización ---
        char categoria = 'A';
        switch (categoria) {
            case 'A':
                System.out.println("Prioridad de envío: Alta");
                break;
            case 'B':
                System.out.println("Prioridad de envío: Media");
                break;
            default:
                System.out.println("Prioridad de envío: Estándar");
        }

        // Error léxico 5: Uso de símbolos no reconocidos por el lenguaje fuera de strings
        int datoInvalido = 500; 

        // --- Finalización del Programa ---
        System.out.println("Cerrando conexión con la base de datos...");
        System.out.println("¡Gracias por usar Tienda Pro!");
        
        // Líneas de relleno para completar la estructura solicitada
        // .......................................................
        // .......................................................
        // .......................................................
        // Fin del código.
        input.close();
    }
}