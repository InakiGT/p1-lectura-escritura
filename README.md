## Funcionamiento del Proyecto:
El siguiente proyecto consta en la implementación de las funciones de entrada y salida estándar en lenguaje ensamblador a partir de un código en alto nivel con nombre main.c.  El cual tiene como objetivo calcular la media de un arreglo de enteros positivos con un tamaño fijo de 11 y que el usuario proporcione los numeros enteros mediante el teclado.
 Cabe resaltar que al momento de ingresar numeros mediante el teclado en realidad, se recibe caracteres en ascii, por tanto hay que convertir esa entrada del teclado a un numero entero.



## Configuracion del Hardware:
Debido a que se tiene una PC cuya arquitectura es de intel x86-64 bits. Es necesario instalar un compilador cruzado que permita crear ejecutables propios de una arquitectura distinta de la PC que se posea.Tomando en cuenta una distribucion de Linux Ubuntu 
 1. Instalacion del compilador cruzado con el comando sudo apt install gcc-arm-linux-gnueabi qemu-user-static
 2. Establecimiento de alias para los comandos del compilador cruzado
        alias arm-gcc=arm-linux-gnueabi-gcc-11
        alias arm-as=arm-linux-gnueabi-as
        alias arm-objdump=arm-linux-gnueabi-objdump
        alias arm-run=qemu-arm-static
 La funcion de estos comandos sera descrita en el apartado "Compilacion del software"



## Compilacion del software
 La restriccion que tiene el compilador cruzado es que solo podremos utilizarlo con archivos.c y no con archivos.cpp
Teniendo un archivo con extension .c en este caso main.c procederemos a compilar.

1. Generacion del archivo ensamblador con extension .s con el comando "arm-gcc -S main.c -march=armv7-m -mtune=cortex-m3" el cual nos sirve para generar un archivo de ensamblador a partir del código fuente de "main.c"
	**Significado de banderas:**
	- -S: indica al compilador que genere un archivo de salida en formato de código ensamblador en lugar de un ejecutable
	- -march=armv7-m: indica al compilador que sea para arquitectura ARMv7-M
	- -mtune=cortex-m3: indica al compilador que es para un procesador Cortex-M3
2. Generacion del archivo objeto con extension .o a partir de un archivo de tipo ensamblador con extension .s con el comando "arm-as main.s -o main.o"
	**Significado de banderas:**
	- -o: indica el nombre del archivo de salida generado. En este caso el nombre sera "main.o"

3. Generacion del archivo ejectubale con extension .elf a partir de un archivo de tipo objeto con extension .o con el comando "arm-gcc main.o -o main.elf -static"
	**Significado de banderas:**
	- -o: indica el nombre del archivo de salida generado. En este caso el nombre sera "main.elf"
	- -static: indica al compilador que utilice biblioteca estatica para la generacion del archivo con extension .elf

4. Ejecucion del archivo ejecutable con extension.elf con el comando "arm-run main.elf"


## Marcos de funciones
#### my_atoi (conversion de ascii a entero)
Tamaño del marco : **24 bytes**

	r7 -> 0
	vacío -> 4
	r2 -> 8
	r3 -> 12
	r6 -> 16
	r9 -> 20
	vacío ->24
		
#### read_user_input (implementacion de printf)
Tamaño del marco : **16 bytes**

	r7 -> 0
	vacío -> 4
	r0 -> 8
	r1 -> 12

#### int_to_string
Tamaño del marco : **40 bytes**

	r7 -> 0
	vacío -> 4
	r1 -> 8
	r3 -> 12
	r3 -> 16
	r5 -> 20
	r4 -> 24
	r6 -> 28
	r6 -> 32

#### display (implementacion de scanf)
Tamaño del marco : **16 bytes**

	r7 -> 0
	vacío -> 4

### media (cálculo de la media de un arreglo)
Tamaño del marco : **24 bytes**

	r7 -> 0
	vacío -> 4
	r0: array -> 8
	r3: size -> 12
	r3: sum -> 16
	r3: i -> 20

#### main
Tamaño del marco : **56 bytes**

	r7 -> 0
	vacío -> 4
	r3: numbers -> 8
	r3: numbers -> 12
	r3: numbers -> 16    
	r3: numbers -> 20
	r3: numbers -> 24
	r3: numbers-> 28
	r3: numbers -> 32
	r3: numbers -> 36
	r3: numbers -> 40
	r3: numbers -> 44
	r3: numbers -> 48
	r3: i -> 52
	r3: out -> 56
