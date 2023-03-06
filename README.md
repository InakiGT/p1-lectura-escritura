Práctica II Programación de E/S en lenguaje arm
Funcionamiento
El siguiente proyecto procesa un arreglo de 11 elementos que son ingresados desde la entrada estándar, el programa está diseñado para calcular la media de los elementos del arreglo y el resultado se puede visualizar en la terminal estándar.
Comandos de compilación
El comando para obtener el código objeto en lenguaje ensamblador arm es el siguiente:
arm-linux-gnueabi-as main.s -o main
El comando:
arm-linux-gnueabi-gcc main.o -o main.elf -static
Es para crear el programa ejecutable usamos la extensión .elf y la opción -static porque el programa no tiene dependencias de bibliotecas dinámicas ya que usamos la función main como función principal.
El comando para ejecución del programa utilizando el emulador quemu es el siguiente:
qemu-arm ./main.elf
