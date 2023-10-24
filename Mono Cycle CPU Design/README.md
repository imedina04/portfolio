[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/kPUcCREH)
# Daisy Chain mediante microcontrolador RISC-V desarrollado con System Verilog

## 1. Abreviaturas y definiciones
- **FPGA**: Field Programmable Gate Arrays

## 2. Referencias
[0] David Harris y Sarah Harris. *Digital Design and Computer Architecture. RISC-V Edition.* Morgan Kaufmann, 2022. ISBN: 978-0-12-820064-3

## 3. Desarrollo

### 3.1 Módulo "controller"
El módulo 'controller' recibe una intrucción y le indica al microcontrolador el tipo de operación a relizar. 

#### 1 Encabezado del módulo
```SystemVerilog
module controller(
    input  logic [6:0] op_i,
    input  logic [2:0] funct3_i,
    input  logic       funct7b5_i,
    input  logic       zero_i,
    
    output logic [1:0] resultsrc_o,
    output logic       memwrite_o,
    output logic       pcsrc_o, 
    output logic       alusrc_o,
    output logic       regwrite_o, 
    output logic       jump_o,
    output logic [1:0] immsrc_o,
    output logic [2:0] alucontrol_o
);
```
#### 2. Parámetros
- Este modulo no posee parametros

#### 3. Entradas y salidas:
- `op_i`: entrada con instrucción del bit 0 al 6 
- `funct3_i`: entrada con instrucción del bit 12 al 14 
- `funct7b5`: entrada con el bit 30 de la instrucción 
- `zero_i`: entrada con la bandera de cero de la ALU
- `resultsrc_o`: salida que selecciona si el dato viene de la ALU, de la RAM o de PC+4
- `memwrite_o`: salida que le dice a la RAM que se va a escribir un dato
- `pcsrc_o`: salida que seleeciona si el dato viene del PC+imm o del PC+4
- `alusrc_o`: salida que selecciona el dato de la entraba b de la ALU (inmediato o el registro 2 del banco de registros)
- `regwrite_o`: salida que le dice al banco de registros si escribir o no
- `jump_o`: salida que hace de bandera de salto
- `immsrc_o`: salida que habilita el extend
- `alucontrol_o`: Selecciona operación de la ALU


#### 4. Criterios de diseño
El diseño de este modulo se baso en el bloque de control de los procesadores tipo RISC-V, el diagrama de bloques se aprecia a continuacion.

![control](doc/Procesador/controll.png)


#### 5. Testbench
Este modulo no posee testbench



### 3.2 Módulo "datapath"

El módulo datapath maneja el PC, el banco de registros, saltos de branch, generador de inmediatos.
#### 1. Encabezado del módulo

```SystemVerilog
module datapath(
    input  logic        clk_i, 
    input  logic        reset_i,
    input  logic [1:0]  resultsrc_i,
    input  logic        pcsrc_i, 
    input  logic        alusrc_i,
    input  logic        regwrite_i,
    input  logic [1:0 ] immsrc_i,
    input  logic [2:0 ] alucontrol_i,
    input  logic [31:0] instr_i,
    input  logic [31:0] readdata_i,
    
    output logic        zero_o,
    output logic [31:0] pc_o,
    output logic [31:0] aluresult_o, 
    output logic [31:0] writedata_o

);
```

#### 2. Parámetros
El módulo no posee parámetros.

#### 3. Entradas y salidas:
- `clk_i`: entrada con señal de reloj
- `reset_i`: entrada de reseteo
- `resultsrc_i`: entrada que selecciona si el dato viene de la ALU, de la RAM o de PC+4
- `pcsrc_i`: entrada que selecciona si el dato viene del PC+imm o del PC+4
- `alusrc_i`: entrada que selecciona el dato de la entraba b de la ALU (inmediato o el registro 2 del banco de registros)
- `regwrite_i`: entrada que habilita escritura en el banco de registros
- `immsrc_i`: entrada que habilita el extend
- `alucontrol_i`: entrada que selecciona la operación de la ALU
- `zero_o`: salida con bandera de 0
- `pc_o`: salida con la dirección de la instrucción
- `instr_i`: Entrada con la instrucción de la ROM
- `aluresult_o`: Salida con el resultado de la ALU
- `writedata_o`: Salida con el dato que entra a la RAM
- `readdata_i`: Entrada con el dato que sale de la RAM


#### 4. Criterios de diseño
El diseño de este modulo se baso en el bloque del datapath de los procesadores tipo RISC-V, el diagrama de bloques se aprecia a continuacion.

![datapath](doc/Procesador/datapath.png)

#### 5. Testbench
Este modulo no posee testbench

### 3.3 Módulo "RAM"

El módulo RAM es la memoria temporal de los datos.

#### 1. Encabezado del módulo

```SystemVerilog
RAM ram (
        .a      (dataadr_o[7:0]),      // input wire [7 : 0] a
        .d      (writedata_o),      // input wire [31 : 0] d
        .clk    (clk2),  // input wire clk
        .we     (memwrite_o),    // input wire we
        .spo    (readdata)  // output wire [31 : 0] spo
    );
```

#### 2. Parámetros
El módulo no posee parámetros.

#### 3. Entradas y salidas:
- `a`: entrada con la direccion del espacio de memoria
- `d`: dato de entrada
- `clk`: entrada con la senal de reloj
- `we`: entrada que habilita escritura 
- `spo`: dato de salida


#### 4. Criterios de diseño
El modulo es un IP-Core que ofrece el software de diseño digital VIVADO.

#### 5. Testbench
Este modulo no posee testbench

### 3.4 Módulo "ROM"
El modulo ROM es la memoria de instrucciones del procesador

#### 1. Encabezado del módulo

```SystemVerilog
ROM rom (
	.a      (pc[10:2]),      // input wire [8 : 0] a
	.spo    (instr)  // output wire [31 : 0] spo
);

```

#### 2. Parámetros
El módulo no posee parámetros.

#### 3. Entradas y salidas:
- `a`: entrada de direccion a la memoria
- `spo`: instruccion correspondiente a la entrada de direccion.


#### 4. Criterios de diseño
El modulo es un IP-Core que ofrece el software de diseño digital VIVADO.

#### 5. Testbench
Este modulo no posee testbench


### 3.5 Módulo "riscvsingle"

El módulo riscvsingle combina el datapath con el controller.
#### 1. Encabezado del módulo

```SystemVerilog
module riscvsingle(
    input  logic        clk_i, 
    input  logic        reset_i,
    input  logic [31:0] instr_i,
    input  logic [31:0] readdata_i,
    
    output logic [31:0] pc_o,
    output logic        memwrite_o,
    output logic [31:0] aluresult_o, 
    output logic [31:0] writedata_o
);
	
```

#### 2. Parámetros
El módulo no posee parámetros.

#### 3. Entradas y salidas:
- `clk_i`: Entrada de reloj del módulo.
- `reset_i`: Entrada de reset del módulo.
- `instri`: Entrada del módulo. Salida de la ROM.
- `readdata_i`: Salida del módulo. Salida de la RAM.
- `pc_o`: Salida del módulo. Indica la posición en las intrucciones.
- `memwrite_o`: Salida del módulo. Indica si se escribe en la RAM.
- `aluresult_o`: Salida del módulo. Salida de la ALU.
- `writerata_o`: Salida del módulo. Dato que ingresa en la RAM.


#### 4. Criterios de diseño
El diseño de este modulo se baso en el bloque del microcontrolador ensamblado con el datapath y el controller de los procesadores tipo RISC-V, el diagrama de bloques se aprecia a continuacion.

![riscvsingle](doc/Procesador/riscvsingle.png)

#### 5. Testbench
La simulacion busca realizar una serie de instrucciones de ensamblador con el fin de que el procesador siga un camino determinado, si las instrucciones se ejecutaron correctamente el procesador llegara a una meta que es la instruccion final que evaluara si el procesador funciona correctamente mediante el resultado de la instruccion final, la prueba final es que guarde 25 decimal en la direccion 100.

![simulacion](doc/Procesador/riscvsimulation.png)

### 3.6 Módulo "demux_procesador"
El módulo 'demux_procesador' recibe una dirección y una señal de we y envía este we al periférico que se encuentre en la dirección recibida. 

#### 1 Encabezado del módulo
```SystemVerilog
module demux_procesador (
	input logic [31 : 0]  dmux_sel_i,
	input logic           we_i,

	output logic we_ram_o,
	output logic we_uart_a_o,
	output logic we_uart_b_o,
	output logic we_uart_c_o,
	output logic we_switches_o,
	output logic we_led_o,
	output logic we_siete_segmentos_o
);
```
#### 2. Parámetros
- Este modulo no tiene parametros

#### 3. Entradas y salidas:
- `dmux_sel_i`: entrada de dirección para selección del periférico
- `we_i`: entrada de write enable 
- `we_ram_o`: salida de write enable hacia la ram
- `we_uart_a_o`: salida de write enable hacia el uart a
- `we_uart_b_o`: salida de write enable hacia el uart b
- `we_uart_c_o`: salida de write enable hacia el uart c
- `we_switches_o`: salida de write enable hacia los switches
- `we_led_o`: salida de write enable hacia los leds
- `we_siete_segmentos_o`: salida de write enable hacia el siete segmentos


#### 4. Criterios de diseño

Se creó un demux con una entrada de write enable, y una entrada de dirección, el cual tiene siete salidas que van hacia los periféricos

#### 5. Testbench
Este modulo no posee testbench

### 3.7 Módulo "mux_procesador"
El módulo 'mux_procesador' recibe datos desde los periféricos y la dirección del periférico y envía este dato al procesador

#### 1 Encabezado del módulo
```SystemVerilog
module mux_procesador (
    input logic [31 : 0] mux_sel_i,
    input logic [31 : 0] ram_i,
    input logic [31 : 0] uart_a_i,
    input logic [31 : 0] uart_b_i,
    input logic [31 : 0] uart_c_i,
    input logic [31 : 0] switches_i,
    input logic [31 : 0] led_i,
    input logic [31 : 0] siete_segmentos,

    output logic [31 : 0] mux_o

);
```
#### 2. Parámetros
- Este modulo no tiene parametros

#### 3. Entradas y salidas:
- `mux_sel_i`: entrada de dirección del periférico
- `ram_i`: entrada de dato desde la ram
- `uart_a_i`: entrada de dato desde el uart a
- `uart_b_i`: entrada de dato desde el uart b
- `uart_c_i`: entrada de dato desde el uart c
- `switches_i`: entrada de dato desde los switches
- `led_i`: entrada de dato desde los leds
- `siete_segmentos`: entrada de dato desde el siete segmentos
- `mux_o`: salida da dato hacia el procesador  


#### 4. Criterios de diseño

Se creó un mux con 7 entradas de datos y una entrada de dirección, y una salida con el dato seleccionado.

#### 5. Testbench
Este modulo no posee testbench

### 3.8 Módulo "bus_addr"
El módulo 'bus_addr' une los módulos mux_procesador y demux_procesador y corresponde a un bus de direcciones

#### 1 Encabezado del módulo
```SystemVerilog
module bus_addr (

// Entradas que vienen del microprecesador
    input logic [31 : 0] addr_mp_i,
    input logic          we_mp_i,
    input logic [31 : 0] data_mp_i,

// Dato de salida que envia el microprocesador
    output logic [31 : 0] data_mp_o,

//Entradas del dato leido de los perifericos

    input logic [31 : 0] read_ram_i,
    input logic [31 : 0] read_swithces_i,
    input logic [31 : 0] read_uart_a_i,
    input logic [31 : 0] read_uart_b_i,
    input logic [31 : 0] read_uart_c_i,
    input logic [31 : 0] read_siente_segmento_i,
    input logic [31 : 0] read_led_i,

// Salidas de los wr enable para cada periférico
    
    output logic we_ram_o,
    output logic we_uart_a_o,
    output logic we_uart_b_o,
    output logic we_uart_c_o,
    output logic we_switches_o,
    output logic we_led_o,
    output logic we_siete_segmentos_o,

// Salida dato que viene del procesador 

    output logic [31 : 0] dato_pr_o,

// Salida para controlar los UART

    output logic regg_sel_o,
    output logic adddr_o,

// Salida para controlar las lineas del ram

    output logic [7 :0] addr_ram_o

);
```
#### 2. Parámetros
- Este modulo no tiene parametros

#### 3. Entradas y salidas:
- `addr_mp_i`: entrada de dirección que viene del microprocesador 
- `we_mp_i`: entrada de write enable que viene del microprocesador
- `data_mp_i`: entrada de dato que viene del microprocesador
- `read_ram_i`: entrada de dato desde la ram
- `read_uart_a_i`: entrada de dato desde el uart a
- `read_uart_b_i`: entrada de dato desde el uart b
- `read_uart_c_i`: entrada de dato desde el uart c
- `read_switches_i`: entrada de dato desde los switches
- `read_led_i`: entrada de dato desde los leds
- `read_siete_segmento_i`: entrada de dato desde el siete segmentos
- `we_ram_o`: salida de write enable hacia la ram
- `we_uart_a_o`: salida de write enable hacia el uart a
- `we_uart_b_o`: salida de write enable hacia el uart b
- `we_uart_c_o`: salida de write enable hacia el uart c
- `we_switches_o`: salida de write enable hacia los switches
- `we_led_o`: salida de write enable hacia los leds
- `we_siete_segmentos_o`: salida de write enable hacia el siete segmentos
- `dato_pr_o`: salida de dato que viene del procesador  
- `regg_sel_o`: salida de control para los uart 
- `addr_o`: salida de dirección para controlar los uart
- `addr_ram_o`: salida para controlar las lineas de la ram 
- `data_mp_o`: salida de dato que envía el microprocesador 

#### 4. Criterios de diseño

El diseño se basó en el siguiente diagrama de bloques:

![bus_addr](doc/bus%20de%20direcciones.png)

#### 5. Testbench
En esta simulación se enviaron datos desde los periféricos hacia el microprocesador y de igual forma se enviaron write enable desde el microprocesador hacia los periféricos y se comprobó su correcto funcionamiento.

![bus_addr](doc/tb_bus_addr.png)

### 3.9 Módulo "registro_leds"
El módulo 'registro_leds' corresponde a un registro que se mostrará en los leds utilizado para mostrar números binarios, entre otros. 

#### 1 Encabezado del módulo
```SystemVerilog

module registro_leds (

    input logic             clck_i,
    input logic             rst_i,
    input logic  [31 : 0]   data_i,
    input logic             we_i,
    
    output logic [31 : 0]   reg_leds_o

);


```
#### 2. Parámetros
- Este modulo no tiene parametros

#### 3. Entradas y salidas:

- `clck_i`: Entrada del clock
- `rst_i`: Reset del registro
- `data_i`: Datos que se deben guardar
- `we_i`: Indicador de guardar los datos
- `reg_leds_o`: Salida de los datos guardados


#### 4. Criterios de diseño

El criterio de diseño corresponde a la siguiente figura

![registro_leds](https://github.com/TDD-23-I/lab4-g2/blob/main/doc/leds.jpg)

#### 5. Testbench

Debido a la sencillez del modulo y que usa instrumentos ya probados anteriormente no se raelizó testbench.

### 3.10 Módulo "registro_swithces"
El módulo 'registro_switches' corresponde a un registro que refleja los switches de la fpga 
#### 1 Encabezado del módulo
```SystemVerilog

module registro_switches (

input logic           clck_i,
input logic           rst_i,

input  logic [15 : 0] switches_i,
input  logic [ 3 : 0] botones_i,
output logic [31 : 0] registro_switches_o 

);


```
#### 2. Parámetros
- Este modulo no tiene parametros

#### 3. Entradas y salidas:

- `clck_i`: Entrada del clock
- `rst_i`: Reset del registro
- `switches_i`: Datos que ingresan de los switches
- `botones_i`: Datos que representan los botones
- `registro_switches_o`: Registro switches del dato generado por los switches


#### 4. Criterios de diseño

El criterio de diseño corresponde a la siguiente figura
![registro_swithces](https://github.com/TDD-23-I/lab4-g2/blob/main/doc/switcvhes.jpg)

#### 5. Testbench

Debido a la sencillez del modulo y que usa instrumentos ya probados anteriormente no se raelizó testbench.

### 3.11 Módulo "top_UART"

Este módulo corresponde al módulo top del UART donde se unen todos los módulos necesarios para que funcione el mismo.

#### 1. Encabezado del módulo
```SystemVerilog
module top_UART (
    input logic         clk_pi,
    input logic         btn_send_pi,      
    input logic         btn_clear_pi,     
    input logic         btn_write_pi,     
    input logic         btn_read_pi,      
    input logic         switch_read_pi,   
    input logic [7:0]   data_in_pi,
    input logic         rx,         

    output logic [7:0]  leds_po,
    output logic        tx
    
);
```
#### 2. Parámetros
No hay parámetros en este módulo.

#### 3. Entradas y salidas:
- `clk_i`: Entrada de reloj
- `btn_send_pi`: Botón que indica que se está enviando un dato a la computadora
- `btn_clear_pi`: Botón para borrar el bit de new_rx
- `btn_write_pi`: Botón que indica que se debe escribir el dato dado por la FPGA en el banco de registros
- `btn_read_pi,`: Botón que indica que se quiere leer un dato del banco de registros
- `switch_read_pi`: Switch utilizado para decidir cual de los dos registros se quiere leer
- `data_in_pi`: Dato a enviar desde la FPGA hacia la computadora
- `rx`: Entrada serial 
- `leds_po`: LEDS para ver el dato enviado/recibido
- `tx`: Salida serial

#### 4. Criterios de diseño
El criterio de diseño de este módulo se basa en el diagrama de bloques de alto nivel mostrado en la siguiente figura:
![bloque_uart](https://github.com/TDD-23-I/lab4-g2/blob/main/doc/Diagrama%20de%20bloques%20UART.png)


#### 5. Testbench
El testbench se encuentra en `tb_top_UART.sv` .En la siguiente figura se observa el testbench en simulación post-síntesis del módulo top UART. En la prueba se observa en primer lugar el dato que se quiere enviar, que en este caso es un "a5" en hexadecimal, luego se observa el pulso del boton guardar, luego el boton de enviar y por ultimo el boton de read, con el switch_read en bajo, para leer el dato a enviar en la salida "leds_o", un tiempo después se observa donde se incia la transmisión mediante la señal serial "tx". Por último, se puso un dato de prueba en rx para simular el dato recibido, se utilizó el numero "d4" en hexadecimal, se espera un tiempo para recibir el dato , se presiona el boton read, con el switch_read en alto y efectivamente se muestra en los leds el dato recibido.
![tb_top](https://github.com/TDD-23-I/lab4-g2/blob/main/doc/testbench_uart.png)

### 3.12 Módulo "registro_7_segmentos"
El módulo 'registro_segmentos' corresponde a un registro que refleja los switches de la fpga los cuales se mostraran usando el 7 segmentos del lab 2 

#### 1 Encabezado del módulo
```SystemVerilog

module s_register(
    input logic        clk_i,
    input logic        reset_i,
    input logic        we_i,
    input logic [15:0] data_i,
    
    output logic [6:0] seg_o,
    output logic [3:0] en_o
    );


```
#### 2. Parámetros
- Este modulo no tiene parametros

#### 3. Entradas y salidas:

- `clck_i`: Entrada del clock
- `rst_i`: Reset del registro
- `we_i`: Indicador de escritura en el registro
- `data_i`: Datos que se guardarán
- `seg_o`: Segmentos que se encenderán
- `en_o`:enables para cada display

#### 4. Criterios de diseño

El criterio de diseño corresponde al mostrado en la siguiente imagen

![registro7s](https://github.com/TDD-23-I/lab4-g2/blob/main/doc/7registro.jpg)

#### 5. Testbench

![registro7s](https://github.com/TDD-23-I/lab4-g2/blob/main/doc/Simulacion_7s.png)

### 3.13 Aplicación en Python

Corresponde a la aplicación en el PC encargada de la recepción y envió de datos hacia lo demás componentes de la red daisy-chain. Utiliza la biblioteca de python `pyserial` para la comunicación serial y `tkinter` para la interfaz gráfica de usuario.

#### 1 Función "comunicacion_serial"

Funcíon que se encarga de establecer la comunicación serial con el puerto serie disponible.

```Python

def comunicacion_serial():
    global ser, port, baud_rate
    ser = serial.Serial(
        
        port= port,
        baudrate=baud_rate,
        bytesize=8,
        parity='N',
        stopbits=1,
        timeout=0.1
    )
```
##### 1. Variables

- `port`: Variable global del puerto serie al que se desea conectar.
- `baud_rate`:  Variable goblal de la velocidad de transmisión en baudios.
- `ser`: Objeto de la funcion `serial` que permite interactuar con el puerto serie.

#### 2. Función "enviar_dato"

Se encargada de la transmisión de datos de manera serial mediante el protocolo UART. Toma un valor hexadecimal ingresado por el usuario mediante la interfaz gráfica, lo convierte en un entero y lo envía a través de la comunicación serial.

```Python
def enviar_dato():
    dato_enviar = int(entry2.get(), 16)
    ser.write(bytes([dato_enviar]))
```
##### 1. Variables

- `dato_enviar`: Almacena el número entero a enviar.

#### 3. Función "leer_dato"

Se encarga recibir los datos mediante el puerto serial. Verifica el destino, actualiza los contadores de recibidos y procesados según las condiciones, y muestra los resultados en la interfaz gráfica.

```Python
def leer_dato():
    global contador_procesados, contador_recibidos
    if ser is not None and ser.in_waiting > 0:
        dato_recibido = ser.read(1) 
       
        if dato_recibido[0] & 0x0F == 0:  # >> 4:
            dato_a_mostrar = dato_recibido[0] >> 4
            contador_procesados +=1
            contador_recibidos +=1 
            contador_procesados_label.config(text=f'{contador_procesados}')
            contador_recibidos_label.config(text=f'{contador_recibidos}')
            dato_label.config(text=f'Dato: {dato_a_mostrar}')
        else:
            contador_recibidos +=1 
            contador_recibidos_label.config(text=f'{contador_recibidos}')
         
    ventana.after(100, leer_dato) # Ejecutar la funcion despues de 100 milisegundos
```
#### 1. Variables

- `dato_recibido`: Almacena el byte recibido mediante el puerto serial.
- `dato_a_mostrar`: Almacena el dato a mostrar en la interfaz gráfica.
- `contador_procesados`: Almacena el número de datos procesados, los que cumplen la condicion del identificador de destino.
- `contador_recibidos`: Almacena el número de datos recibidos por el puerto serial.

#### 4. Criterios de diseño

El criterio de diseño para la aplicación en python se basa en el siguiente diagrama de flujo:

![diagrampyhton](doc/Python/DiagramPython.jpeg)

#### 5. Interfaz gráfica 

La interfaz gráfica de usuario de la aplicación se aprecia en la siguiente figura:

![gui](doc/Python/GUI.png)


### 3.14 Programacion en ensamblador 
Corresponde a la programacion del comportamiento del procesador, especificamente un Daisy Chain que corresponde a una unidad que puede recibir y enviar paquetes a direcciones solicitadas.

#### 1 Programacion en hexadecimal
Instrucciones que interpreta el procesador y estan guardadas en la memoria ROM.

```
00000f13
00000f93
02000093
00809093
00008093
02000113
00811113
00410113
02000193
00819193
00818193
02000213
00821213
01020213
02000293
00829293
01828293
02000313
00831313
01c30313
02000393
00839393
02038393
02000413
00841413
02840413
02000493
00849493
02c48493
02000513
00851513
03050513
02000593
00859593
03858593
02000613
00861613
03c60613
0040006f
00022883
0003a903
00052983
00200a13
0148fab3
094a8e63
01497ab3
0b4a8e63
0149fab3
0d4a8e63
01000713
00c71713
0000a683
00e6f7b3
02e78063
fc5ff06f
01000713
00c71713
0000a683
00e6f7b3
fee788e3
fadff06f
0000a683
0ff00713
00e6f6b3
00100713
00d2a023
00e22023
00d42023
00e3a023
00d5a023
00e52023
0040006f
00100693
00022703
00d77733
fed70ae3
0003a783
00d7f7b3
fed784e3
00052803
00d87833
fcd80ee3
f95ff06f
0000a683
00f00893
00889893
0116f6b3
00032903
00f00893
011979b3
00899993
13368e63
0540006f
0000a683
00f00893
00889893
0116f6b3
0004a903
00f00893
011979b3
00899993
15368463
0580006f
0000a683
00f00893
00889893
0116f6b3
00062903
00f00893
011979b3
00899993
15368a63
05c0006f
001f0f13
00032903
00000693
00d22023
01242023
0125a023
00100693
00d3a023
00d52023
01e12023
05c0006f
001f0f13
0004a903
00000693
00d3a023
0122a023
0125a023
00100693
00d22023
00d52023
01e12023
0500006f
001f0f13
00062903
00000693
00d52023
0122a023
01242023
00100693
00d22023
00d3a023
01e12023
0440006f
00100693
0003a783
00d7f7b3
fed78ae3
00052803
00d87833
fed804e3
e79ff06f
00100693
00022783
00d7f7b3
fed78ae3
00052803
00d87833
fed804e3
e59ff06f
00100693
00022783
00d7f7b3
fed78ae3
0003a803
00d87833
fed804e3
e39ff06f
001f8f93
001f0f13
0f000893
00032683
0116f6b3
0046d693
004f9e93
00de86b3
00d1a023
01e12023
00000693
00d22023
e05ff06f
001f8f93
001f0f13
0f000893
0004a683
0116f6b3
0046d693
004f9e93
00de86b3
00d1a023
01e12023
00000693
00d3a023
dd1ff06f
001f8f93
001f0f13
0f000893
00062683
0116f6b3
0046d693
004f9e93
01d686b3
00d1a023
01e12023
00000693
00d52023
d9dff06f
```

#### 2. Criterios de diseño

El algoritmo de la programacion en ensamblador se aprecia en la siguiente imagen 

![asembler](doc/Procesador/asembler.png)


### 3.15 Módulo "top"
El módulo 'top' corresponde al top con todos los periferios, el microprocesador, y la ram  

#### 1 Encabezado del módulo
```SystemVerilog

module top(
    input  logic            clk_i,
    input  logic            rst_i,
    
    input logic  [ 3 : 0]   botones_i,
    input logic  [15 : 0]   switches_i, 
    
    input  logic            rx_a,
    
    output logic            tx_a,
    input  logic            rx_b,
    
    output logic            tx_b,
    input  logic            rx_c,
    
    output logic            tx_c,
    output logic [15 :0]    leds_o,
    output logic [6 : 0]    siete_segmento_o,
    output logic [3 : 0]    enable_o
    
);


```
#### 2. Parámetros
- Este modulo no tiene parametros

#### 3. Entradas y salidas:

- `clck_i`: Entrada del clock
- `rst_i`: Reset del registro
- `botones_i`: Datos ingresador por los botones
- `switches_i`: Datos ingresador por switches
- `rx_a`: Corresponde al rx del uart a
- `tx_a`:Corresponde al tx del uart a
- `rx_b`: Corresponde al rx del uart b
- `tx_b`:Corresponde al tx del uart b
- `rx_c`: Corresponde al rx del uart c
- `tx_c`:Corresponde al tx del uart c
- `leds_o`:Corresponde al la salida del registro de leds
- `siete_segmento_o`:Corresponde al número que va al 7 segmentos
- `enable_o`:Corresponde al enable para cada display
#### 4. Criterios de diseño

El criterio de diseño corresponde al mostrado en la siguiente imagen

![top](https://github.com/TDD-23-I/lab4-g2/blob/main/doc/Top.png)

#### 5. Testbench

El testbench corresponde a la siguiente figura. En este se puede ver el funcionamiento del sistema para la prueba Daisy Chain
![top]()



## Apendices:
### Apendice 1:
texto, imágen, etc




