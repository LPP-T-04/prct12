# LppT04Matrix

:~/LPP/prct09/tree  
.  
├── Gemfile  
├── Gemfile.lock  
├── Guardfile  
├── lib  
│   ├── lpp_t_04_matrix  
│   │   └── version.rb  
│   └── lpp_t_04_matrix.rb  
├── LICENSE.txt  
├── lpp_t_04_matrix.gemspec  
├── Rakefile  
├── README.md  
└── spec  
    ├── lpp_t_04_matrix_spec.rb  
    └── spec_helper.rb    

## Descripción de los objetivos de la práctica

Para realización de esta práctica se ha creado una jerarquía de clases.Teniendo en cuenta que tenemos una clase abstracta de nombre Matriz, y de la cual han heredado las otras dos clases que definen el tipo de objetos que tenemos, MatrizDensa y MatrizDispersa, se han implementado los métodos para operar con ambos tipos de matrices sin importar que objeto sea. Además se ha incluido el tratamiento de fracciones desarrollado en la práctica anterior con la idea de que la matriz sea capaz de operar con elementos del tipo Franction. Los métodos implemnetados son:  
    Suma, Resta, Multiplicación y Traspuesta.    
***


## Jerarquía de clases para la creación las matrices:

class Matriz<pre>
    @filas
    @columnas
</pre>
end  

Class MatrizDensa < Matriz
<pre>   #Se definen los métodos que trabajan con matrices densas
</pre>
end  

Class MatrizDispersa < Matriz
<pre>    #Se definen los métodos que trabajan con matrices dispersas
</pre>
end  
  
##  Trabajo con matrices  

Un ejemplo de como construiremos una matriz densa es:    
m3 = MatrizDensa.new(2,2,[[7,10],[15,22]])  
Deberemos llamar a la clase MatrizDensa.  
Los dos primero parametros son el número de filas y el número de columnas.  
A continuación se le pasa un arrary que contiene todos los elementos de la matriz.  

Un ejemplo de como construiremos una matriz dispersa es:    
m2 = MatrizDispersa.new(2, 2, {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}})  
Se llama a la clase MatrizDispersa.  
Los dos primero parametros son el número de filas y el número de columnas.  
A continuación se le pasa un hash que contiene los elementos no nulos de la matriz del tipo:  
[FILA] => {[COLUMNA] => [VALOR], [COLUMNA] => [VALOR], ...}, ...  

## Installation

Add this line to your application's Gemfile:

    gem 'lpp_t_04_matrix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lpp_t_04_matrix

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
