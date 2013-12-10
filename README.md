# Práctica de Laboratorio #12 - EQUIPO

## Lenguaje de Dominio Específico (Domain Specific Language - DSL).

* Se define la clase Operaciones encargada de leer del fichero y realizar las operaciones.  
* Se define operar.rb, se encarga de cargar el fichero y hacer la llamada a la clase Operaciones y pasarle el fichero.  
* Se define hoja.rb, hoja de cálculo donde se podrán realizar las distintas operaciones.  

Trabajo con el DSL:  
Se define la operación y el tipo, tantas como operaciones se quieran  realizar:  
    * Suma
    * Resta
    * Multiplicación
    <pre>  
        operacion "suma",  
    </pre>  

Se declaran las matrices, tantas como se quieran operar:  
Tipo de la matriz, número de, filas columnas, => elementos de la matriz.  
    <pre>  
        densa(2,2) =>[[1,2],[3,4]],  
        dispersa(2, 2) => {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}}  
    </pre>  
[![Build Status](https://travis-ci.org/LPP-T-04/prct09.png?branch=master)]