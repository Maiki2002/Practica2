# Práctica_II

**Integrantes:**

Luna Ramírez Stephen.

2203066748.

Salazar Jiménez Ángel Miguel.

2203066846.

Jiménez Cazares Fernando.

2173071926.

## **Descripción del Código Ensamblador (programa)**

**Si la diestra vuestra no es adversaria y el viaje nos es digno, damos inicio a las palabras, ritmo sagrado y devoto, a esta descripción: no quiero agobiar al lector con historias ásperas y largas , no sería  propicio hacerlo, pues, ¿Qué ciencia denotaría algo como ello si con mesura y claridad puede hallarse en un sólo y único párrafo la elocuencia? Seamos, equipo mío, breves y exactos a nuestra imaginación; sea ya la partida de esta meta una división clara que al leerla complete con el problema. Por lo tanto, las acciones se partirán en partes donde cada una de éstas tendrán su exacta interpretación. Es decir, mediante el código ensamblado se mostrará sus funciones  (subrutinas), a las cuales se darán su breve explicación. He aquí, pues, las siguientes secciones:**

### Subrutina 1. Leer (entrada al programa)

**Es necesario tomar en cuenta, que los argumentos que necesitamos para que esta función funcione, provengan de la función principal (main). Los argumentos son:**

- **Dirección base del buffer**
- **Tamaño del buffer**

**Prólogo.** 

**En esta sección, lo primero que se debe de tomar en cuenta es la creación del marco. Para ello, debemos tomar en cuenta los argumentos que vamos a respaldar. En este caso van a ser 2 registros para respaldar los argumentos provenientes del main ( r0, r1). Es decir, que tenemos que reservar espacio para los registros que vamos a ocupar.** 

**Cuerpo de la función:**

**Posteriormente, vamos a cargar en los registros r0, r1 y r2, los valores que nos indican  en la siguiente tabla:**

[**https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md#arm-32_bit_EABI**](https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md#arm-32_bit_EABI)

**Esto con la finalidad de indicarle al sistema operativo que necesitamos entrar en modo de escritura (los valores serán recibidos desde la consola, es decir, la entrada estándar)** 

**Una vez que establecemos los registros correspondientes con los valores indicados en la tabla, llamamos al sistema. El valor obtenido se almacenara en r0 (esto por convención).** 

**Prologo:**

**Lo siguiente que vamos a hacer, es liberar el marco de la función (recuperar el espacio que pedimos prestado) siguiendo las convenciones de ARM.** 

### Subrutina 2. Imprimir (salida al programa, el que otorga el resultado final)

**En esta subrutina, es muy similar lo que se debe de hacer como en la función de “leer”.** 

**Sólo que aquí, la dirección base del buffer tiene que ser completamente diferente a la dirección del buffer para leer.** 

**Prologo:**

**Se debe de tomar en cuenta la creación del marco. Para ello, debemos tomar en cuenta los argumentos que vamos a respaldar. En este caso van a ser 2 registros para respaldar los argumentos provenientes del main ( r0, r1). Es decir, que tenemos que reservar espacio para los registros que vamos a ocupar.** 

**Cuerpo de la función:**

**Lo que va a cambiar aquí, es el valor de r0. Ya que este valor, es diferente al valor que se coloca para leer.** 

**Los demás registros llevaran los valores que se indican en la tabla anterior.** 

**Una vez que establecemos los registros correspondientes con los valores indicados en la tabla, llamamos al sistema.** 

**Prologo:**

**Lo siguiente que vamos a hacer, es liberar el marco de la función (recuperar el espacio que pedimos prestado) siguiendo las convenciones de ARM.** 

### Subrutina 3. ASCII_Entero (aquél que convierte una cadena de caracteres a números enteros [positivos])

**Ante  esta función (llamase subrutina) procesa dos argumentos que son vistos (a bajo nivel) como registros: registro r0 y registro r4. La primera contendrá la dirección de la cadena; y la otra tendrá ese mismo, pero en valor numérico (después de haberlo convertido, por supuesto). Gracias a la pila *stack* denotamos  tres funcionalidades importantes para hacer o invocar a una función, que son las siguientes:  prólogo, el cuerpo de la función y el epílogo. A cada una de éstas tienen su propio camino y su propia diferencia cuya cual es importante mencionar para dar entender su funcionamiento, veamos:**

- **Prólogo (*The begining*)**

**El prólogo no es más que nada el almacén de la pila (*Push*, entrada o asignar) donde primero se hace mencionar su guardado, los valores (registros) que contendrá, dando así el espacio de uso a utilizar. Este espacio otorga el guardado (*they called store or store address*) a una específica dirección de memoria, dependiendo del campo que ha sido ya asignado anteriormente, para después utilizarlo (con esa dirección misma) hacia otro registro que llevará su dato correspondido. No obstante, ARM menciona que para entrar a cada campo de memoria o dirección sean siempre vistos a múltiplos de ocho, no sin olvidar que el conteo es de cuatro para cada pedazo de la pila (direcciones de memoria), así con ello tenemos nuestros argumentos (los datos) ya respaldados a otros (ya que esto es muy importante y bueno para el reciclo de registros) con seguridad.**

- **Cuerpo de la Función (*The Function Body*)**

**En el cuerpo de la subrutina o función se encontrará las instrucciones a realizar o las dichas que queremos desear para que la propia máquina pueda hacer su trabajo (o el de nosotros), no sin antes cargar los datos guardados anteriormente en una respectiva dirección de memoria (*load or load the address*), para posteriormente usar o modificar los valores a ofrecer. Con esto (como bien se observa en el código ensamblador) se da a conocer las instrucciones, o por mejor decir, los llamados *branch condition* (*like the unconditional and the conditional*), *loop* (*for, while-do, do-while*), y otras que poseen ciertas proposiciones lógicas e incluso aritméticas para dar a la solución debida. Ante esto, dentro de un ciclo *while* (etiqueta o *label*) carga una cadena de bytes incrementándolo, no sin olvidar, a uno para cada carácter de la cadena (*string*) que es visualizado como a un arreglo. Luego con esto compara un registro con otro (puede ser incluso con un número inmediato) y otorga una condición booleana que dará verdadero (si cumple) o falso (sino lo cumple) como respuesta; esa misma ejecutará (saltará) hacia un bloque de instrucciones  (siempre y cuando el *flag* sea uno [*True*,verdadero], sino termina o cierra el ciclo de ejecución ). Estas instrucciones dan otras comparaciones más para saber si el *string* (cadena) es una de las letras o números de ‘0’ a ‘9’, si lo son, entonces, restará ese valor (en hexadecimal) con el número 48, pues es necesario hacerlo así, ya que son representados como valores binarios y esto satisface hacia el resultado que queremos dar. No obstante, se multiplica con el número 10 (siendo a nivel ensamblador puede representarse con la instrucción MUL o bien con LSL cuya misma es mucho mejor que el propio MUL),  y leyendo o cargando byte por byte para notificar si su término llegó a  NULL (nulo). Con esto terminará y seguirá después, como normalmente lo hace todo ensamblador, con las demás instrucciones.**

- **Epílogo (*The end*)**

**El epílogo (el contrario amigo del prólogo) da primero el retorno del resultado hacia un registro explícito, el registro r0, que regresará, después de haber invocado la función, el valor ya calculado del programa (salida); sin embargo, se realiza después una suma (de facto, en el prólogo se realiza una resta) que sumará con el número de campos ya denotados anteriormente, luego, entonces, liberará (Pop, quitar o designar) esos valores ya concluidos o guardados con anterioridad. Finalmente, como se observa, retorna la llamada (esto es, en la etiqueta que fue incluida) denotado como “bx lr”.**

### Subrutina 4. Entero_ASCII (Aquél que ahora convierte un número entero [positivo] a un carácter [***char*** o *string*])

**Eneas habló y esto fue lo que me dijo: “Si tus palabras anteriores han explicado ya la funcionalidad de la pila *stack*, donde se muestra cada parte que con lleva (esto es, el prólogo, el cuerpo de la función, y el epílogo), ¿Por qué no tan sólo detallar lo qué hace esa función, conocido por todo programador de lenguaje de bajo nivel, como subrutina? Harto es al piloto tener que acudir a tantos sitios sin pausa alguna”. Entonces, abreviaré esta sabiduría a un término más eficaz: la subrutina llamada como “Entero_ASCII” que posee  dos argumentos, uno para el valor numérico a convertir; y otro el espacio a almacenar (byte por byte, incrementándolo a uno), y bien lo menciona, convierte un entero cualquier a una cadena de caracteres (*string*) para facilitar el uso de la salida (imprimir el resultado final a consola) a través de un código de bajo nivel conocido por todos como ensamblador. ¿Por qué hacer esto, si ya se convirtió y almacenó mediante un arreglo, dichos números que serán luego ya ofrecidos? Imposible es otorgarlo de esta manera, puesto que el ensamblador del micro controlador M no identifica como salida o impreso números enteros o flotantes, sino identifica por cada uno de éstos una representación en hexadecimal que es llevada hacia el código ASCII , por tanto, es sumamente necesario convertir todo número a un código ASCII.**

**Ahora bien, ¿Cómo hacer que se convierta lo antes mencionado? En la anterior subrutina (ASCII_Entero) teníamos que por cada código ASCII (en hexadecimal) se tenía que restar con el número 48 o bien 0x30 en su representación hexal, después multiplicarlo por diez y así sucesivamente hasta ya tener el número adecuado. Pues bien; en este caso es lo contrario. Ahora en vez de restar aquello, sumamos (con el número 48, representado como 0x30) todos esos valores con el código ASCII, es decir, para convertir un dígito d, tenemos que:  *0 ≤ d ≤ 9* para dar a corresponder a una letra, o en pocas palabras, se tiene lo siguiente:** 

                     character[0] = d + 0x30

**o por mejor decir:**

                     character[0] = d + ‘0’

**Sin embargo, no es todo, porque para un número entero, por ejemplo, el “123” , debemos obtener por cada división a diez, un dígito solo para así convertirlo a su forma ASCII, mas hay un problema (al menos para el usuario), y es de que al ya dar aquello dará su forma inversa, esto es, si “123” es ya dividido y convertido se mostraría así: “321”. Cosa que, para el usuario, sería un resultado erróneo. ¿Cómo ofrecer ese número su orden inicial? Ordenar de forma inversa, iniciando con el dígito menos significativo hasta el mayor dígito significativo que éste puede poseer. Con esto se mantendría su orden original.**

### Función Principal: Main (*The Main Subroutine* )

### Prólogo

***Main* está dividido por tres secciones: arreglo, variables locales y respaldo de los registros r7 y lr.
El arreglo será reservado por 20 bytes ya que cada elemento ocupa 4 bytes, las variables ocupan 16 bytes, desperdiciando 4 bytes por convención del ensamblador arm, así como el respaldo de r7 y lr.**

### Leer los datos del arreglo:

**Para leer en cada elemento primero tendremos que pedir al compilador que lea los datas que ingresaremos para que devuelva ese valor dado y convertido en la función leer podamos guardarlo en cada elemento del arreglo empezando de menor a mayor (arreglo[0]-arreglo[4]).**

### FOR 1:

**La primera función *for* se encargará de acceder a cada elemento del arreglo, leer lo que tiene dentro de esta y convertirlo a entero, una vez hecho lo anterior el siguiente paso a realizar será convertir el entero dado por la función y convertirla en ascii nuevamente, se repetirá hasta terminar con todos los elementos del arreglo de tamaño de 5.**

**Después de terminar con la función, procederá a realizar una suma de los elementos que contiene el arreglo mediante una función “suma_arreglo” en el que se le pasa como argumento la dirección del arreglo y el tamaño.**

**En el siguiente paso realiza la conversión de entero a ascii , pasando como argumentos el tamaño del *buffer*, la dirección del *buffer* y el arreglo.**

**Como último pasa se encarga de imprimir lo que contiene el arreglo.** 

### Epílogo:

**Terminando su proceso dentro de *main*, cerramos la pila devolviéndole el valor a r7 y a sp.**

### Función suma_arreglos
**Esta funcion se encarga de acceder a todos los elementos del arreglo dado en los argumentos para sumarlos y puedan ser guardarlos en una variable de retorno.**

## Diagramas de las Funciones, Subrutinas.

1. **Leer**

<img width="501" alt="image" src="https://user-images.githubusercontent.com/105370860/223012680-2dab7a8f-3e14-4978-b286-244337d9059c.png">



2. **Imprimir**

<img width="501" alt="image" src="https://user-images.githubusercontent.com/105370860/223012693-f0cdaf71-d836-4faf-8687-e5699639666b.png">


3. **ASCII_Entero**

![image](https://user-images.githubusercontent.com/105370860/222994855-921cdebb-35f5-44bb-9f4c-06918ab47809.png)


4. **Entero_ASCII**

![image](https://user-images.githubusercontent.com/105370860/222994873-21349210-91ce-47dd-8a13-233daed9d2cb.png)

5. suma_arreglos

<img width="501" alt="image" src="https://user-images.githubusercontent.com/105370860/223012440-9959ef2e-0cd8-439b-97f9-01222f2ceb96.png">


6. **Main:**
<img width="261" alt="Captura de pantalla 2023-03-05 a la(s) 14 59 08" src="https://user-images.githubusercontent.com/105370860/222994274-c4774ffa-bd7e-4db2-8af8-1f6ebc3a9144.png">
