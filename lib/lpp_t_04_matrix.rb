require "lpp_t_04_matrix/version"

# == Modulo que contiene la gema para el trabajo con matrices.
#
# Operacion con matrices densas y dispersas.
#
# Authors: Eliezer Cruz Suarez, Carlos Barreda Falciano
#
# Email: alu0100611298@ull.edu.es, alu0100596113@ull.edu.es
#
# Para realizacion de esta practica se ha creado una jerarquia de clases. 
# Teniendo en cuenta que tenemos una clase abstracta de nombre Matriz, y de la cual han heredado las otras dos clases que definen el tipo de objetos que tenemos, MatrizDensa y MatrizDispersa, se han     implementado los metodos para operar con ambos tipos de matrices, sin importar que objeto sea.
# Además se ha incluido el tratamiento de fracciones desarrollado en la practica anterior con la idea     de que la matriz sea capaz de operar con elementos del tipo Franction. Los metodos implemnetados son:
#
# * Suma.
# * Resta.
# * Multiplicacion.
# * Traspuesta.
# 
module LppT04Matrix 

	# Clase Abstracta Matriz
	class Matriz # Clase Abstracta Matriz
		# Variable que guarda el numero de filas y columnas de la matriz.
	  	attr_accessor :filas, :columnas 
	  	# Contructor de la clase Matriz
	  	def initialize (filas, columnas) # Contructor de la clase Matriz
	  		# Variable que guarda el numero de filas de la matriz.
	  		@filas = filas
	  		# Variable que guarda el numero de columnas de la matriz.
	  		@columnas = columnas
	  	end
	end

	# Clase Matriz Densa hereda de Matriz
	class MatrizDensa < Matriz # Clase Matriz Densa hereda de Matriz
		# Vector en el que se almacena el valor de los elementos de la matriz.
		attr_accessor :elemento
		# Contructor de la clase MatrizDensa
		def initialize (filas, columnas, elemento) # Contructor de la clase MatrizDensa
			super(filas, columnas)
			# Vector en el que se almacena el valor de los elementos de la matriz.
			@elemento = elemento
		end

		# Metodo de acceso a la matriz
		def [](i) # Metodo de acceso a la matriz
			@elemento[i]
 		end

 		# Devuelve el valor del indice i j
 		def indice(i,j) # Devuelve el valor del indice i j
 			@elemento[i][j]
 		end

 		# Convierte la fraccion a una cadena
		def to_s # Convierte la fraccion a una cadena
			imprimir = ""
			@filas.times do |i|
				@columnas.times do |j|
					imprimir << "#{elemento[i][j]} "
				end
				imprimir << "\n"
			end
			imprimir
		end

		# Suma dos Fracciones se le pasa un tipo fraccion.
		def +(other) # Suma dos Fracciones se le pasa un tipo fraccion.
			raise ArgumentError, "La longitud de las matrices no coincide." unless @filas == other.filas && @columnas == other.columnas
			elemento = Array.new
			@filas.times do |i|
				elemento_fila = Array.new
				@columnas.times do |j|
					elemento_fila << @elemento[i][j].+(other.elemento[i][j])
				end
				elemento << elemento_fila
			end
			MatrizDensa.new(@filas, @columnas,elemento)
		end

		# Resta dos Fracciones se le pasa un tipo fraccion.
		def -(other) # Resta dos Fracciones se le pasa un tipo fraccion.
			raise ArgumentError, "La longitud de las matrices no coincide." unless @filas == other.filas && @columnas == other.columnas
			elemento = Array.new
			@filas.times do |i|
				elemento_fila = Array.new
				@columnas.times do |j|
					elemento_fila << @elemento[i][j] - other.elemento[i][j]
				end
				elemento << elemento_fila
			end
			MatrizDensa.new(@filas, @columnas,elemento)
		end

		# Multiplica dos Fracciones se le pasa un tipo fraccion.
		def *(other) # Multiplica dos Fracciones se le pasa un tipo fraccion.
			raise ArgumentError, "La longitud de las matrices no coincide." unless @columnas == other.filas
			elemento = Array.new
			acumulado = 0
			@filas.times do |i|
				elemento_fila = Array.new
				other.columnas.times do |j|
					acumulado = 0
					@columnas.times do |k|
						suma =  @elemento[i][k] * other.indice(k,j)
						acumulado = suma + acumulado
					end
					elemento_fila << acumulado
				end
				elemento << elemento_fila
			end
			MatrizDensa.new(@filas, other.columnas, elemento)
		end

		# Devuelve la trasuesta de una Matriz
		def traspuesta # Devuelve la trasuesta de una Matriz
			elemento = Array.new
			@columnas.times do |i|
				elemento_fila = Array.new
				@filas.times do |j|
					elemento_fila << @elemento[j][i]
				end
				elemento << elemento_fila
			end
			MatrizDensa.new(@columnas, @filas, elemento)
		end

		# Devuelve el valor maximo
		def maximo # Devuelve el valor maximo
			aux = @elemento[0][0]
			@columnas.times do |i|
				@filas.times do |j|
					aux = @elemento[i][j] if @elemento[i][j] > aux
				end
			end
			aux
		end

		# Devuelve el valor minimo.
		def minimo # Devuelve el valor minimo.
			aux = @elemento[0][0]
			@columnas.times do |i|
				@filas.times do |j|
					aux = @elemento[i][j] if @elemento[i][j] < aux
				end
			end
			aux
		end
	end

	# Clase Matriz Dispersa hereda de Matriz
	class MatrizDispersa < Matriz # Clase Matriz Dispersa hereda de Matriz.
		# Hash de hashes que guarda los elementos de la matriz por filas y columnas.
		attr_accessor :elemento
		# Contructor de la clase MatrizDispersa
		def initialize (filas, columnas, elemento) # Contructor de la clase Matriz.
			super(filas, columnas)
			# Hash de hashes que guarda los elementos de la matriz por filas y columnas.
    		@elemento = elemento
		end

		# Metodo de acceso a la matriz.
		def [](i) # Metodo de acceso a la matriz.
			@elemento[i]
 		end

 		# Devuelve el valor del indice i j
 		def indice(i,j) # Devuelve el valor del indice i j
 			elemento = @elemento.fetch(i,0)
 			if elemento!= 0
 				elemento.fetch(j,0)
 			else
 				0
 			end
 		end

 		# Convierte la fraccion a una cadena
		def to_s # Convierte la fraccion a una cadena
			@elemento
		end
		
		# Suma dos Fracciones se le pasa un tipo fraccion.
		def +(other) # Suma dos Fracciones se le pasa un tipo fraccion.
			raise ArgumentError, "La longitud de las matrices no coincide." unless @filas == other.filas && @columnas == other.columnas
			case other
			when MatrizDensa
				other.+(self)
			when MatrizDispersa
				elemento = @elemento.merge(other.elemento){|key, oldval, newval| oldval.merge(newval){|key2, oldval2, newval2|oldval2 + newval2}}
				MatrizDispersa.new(@filas, other.columnas, elemento)
			else
				raise TypeError.new("Cannot coerce #{other.inspect} to a Matriz")
			end
		end

		# Resta dos Fracciones se le pasa un tipo fraccion.
		def -(other) # Resta dos Fracciones se le pasa un tipo fraccion.
			raise ArgumentError, "La longitud de las matrices no coincide." unless @filas == other.filas && @columnas == other.columnas
			case other
			when MatrizDensa
				other.-(self)
			when MatrizDispersa
				elemento = @elemento.merge(other.elemento){|key, oldval, newval| oldval.merge(newval){|key2, oldval2, newval2|oldval2 - newval2}}
				MatrizDispersa.new(@filas, other.columnas, elemento)
			else
				raise TypeError.new("Cannot coerce #{other.inspect} to a Matriz")
			end
		end

		# Multiplica dos Fracciones se le pasa un tipo fraccion.
		def *(other) # Multiplica dos Fracciones se le pasa un tipo fraccion.
			raise ArgumentError, "La longitud de las matrices no coincide." unless @columnas == other.filas
			case other
			when MatrizDensa
				other.*(self)
			when MatrizDispersa
				other = other.traspuesta
				elemento = Hash.new(Hash.new())
				@elemento.each {
					|key, value|
					other.elemento.each {
						|key1, value1|
						acumulado = 0
							value.each {							
								|key2, value2|
								if(value1[key2] != nil)
									acumulado +=  value2 * value1[key2]
								end
							}
						if(acumulado != 0)
							hash = { key1 => acumulado}
							hash2 = {key => hash}
							elemento.merge!(hash2){|key3, oldval, newval| oldval.merge!(newval)}				
						end
					}
				}
				elemento
				MatrizDispersa.new(@filas, other.columnas, elemento)
			else
				raise TypeError.new("Cannot coerce #{other.inspect} to a Matriz")
			end		
		end

		# Devuelve la trasuesta de una Matriz
		def traspuesta  # Devuelve la trasuesta de una Matriz
			elemento = Hash.new(Hash.new())
			@elemento.each {
				|key, value| value.each {
					|key2, value2|  hash = { key => value2}
					hash2 = {key2 => hash}
					elemento.merge!(hash2){|key3, oldval, newval| oldval.merge!(newval)}
				}
			}
			elemento
			MatrizDispersa.new(@filas, @columnas, elemento)
		end

		# Devuelve el valor maximo
		def maximo # Devuelve el valor maximo
			aux = @elemento.keys
			aux1 = aux[0]
			aux2 = @elemento[aux1].values
			mayor = aux2[0]
			@elemento.each {
				|key, value| value.each {
					|key2, value2|
					mayor = indice(key,key2) if indice(key,key2) > mayor
				}
			}
			mayor
		end

		# Devuelve el valor minimo.
		def minimo # Devuelve el valor minimo.
			aux = @elemento.keys
			aux1 = aux[0]
			aux2 = @elemento[aux1].values
			mayor = aux2[0]
			@elemento.each {
				|key, value| value.each {
					|key2, value2|
					mayor = indice(key,key2) if indice(key,key2) < mayor
				}
			}
			mayor
		end
	end
end

# Clase para el trabajo con fracciones.
class Frac
	# Se definen set y get para acceder a las variables de la clase.
	attr_reader :numerador, :denominador # Se definen set y get para acceder a las variables de la clase.
	# Se incluye el modulo de nombre "comparable" utilizado para el operador <=>.
	include Comparable # Se incluye el modulo de nombre "comparable" utilizado para el operador <=>.
	
    # Se define el constructor.
    def initialize(numerador, denominador) # Se define el constructor.
		mcd = gcd(numerador,denominador)
		@numerador , @denominador = numerador/mcd, denominador/mcd
	end
	
	# Devuelve el numerador.
    def num() # Devuelve el numerador.
		@numerador
	end
	
	# Devuelve el denominador.
    def denom() # Devuelve el denominador.
		@denominador
	end
	
	# Si el denominador es 1, solo se imprimer el numerador
    def to_s
        if @denominador == 1 # Si el denominador es 1, solo se imprimer el numerador
                "#{@numerador}"
        elsif @denominador == -1 #En el caso de que b=-1 y a>0 ó a=-1
                if @numerador>0 || @numerador==-1
                        "#{-@numerador}"
                else #Si b=-1 y a es menor que cero, imprime el valor de a
                        "#{@numerador}"
                end
        elsif (@numerador>0 && @denominador>0 && @denominador!=1) #Caso nomal, a y b son mayores que cero, imprime a/b
                "#{@numerador}/#{@denominador}"
        elsif (@numerador>0 && @denominador<0 && @denominador!=-1) # b es menor que cero, se le cambia el signo a todo para que se imprima: -a/b
                "#{-@numerador}/#{-@denominador}"
        elsif (@numerador<0 && @denominador<0 && @denominador!=-1) # a y b son menor que cero, se le cambia el signo a todo para que imprima a/b
                "#{-@numerador}/#{-@denominador}"
        elsif (@numerador<0 && @denominador>0 && @denominador!=1) # a es menor que cero, se imprime igual: -a/b
                "#{@numerador}/#{@denominador}"
        end        
    end
	
	# Imprime el resultado de la fraccion como un float.
    def to_f() # Imprime el resultado de la fraccion como un float.
		@numerador.to_f/@denominador
	end
	
	# Se define el operador <=> para el modulo comparable.
    def <=>(other) # Se define el operador <=> para el modulo comparable.
    	@numerador.to_f/@denominador <=> other.numerador.to_f/other.denominador
    end
    
    # Se calcula el valor absoluto de una fraccion.
    def abs() # Se calcula el valor absoluto de una fraccion.
    	if (@numerador > 0 && @denominador > 0)
    		Frac.new(@numerador, @denominador).to_s
    	elsif (@numerador > 0 && @denominador < 0)
    		Frac.new(@numerador, -1 * @denominador).to_s
    	elsif (@numerador < 0 && @denominador > 0)
    		Frac.new(-1 * @numerador, @denominador).to_s
    	else (@numerador < 0 && @denominador < 0)
    		Frac.new(-1 * @numerador,-1 * @denominador).to_s
    	end  						
    end
    
    # Calcula el reciproco de una fraccion.
    def reciprocal() # Calcula el reciproco de una fraccion.
    	Frac.new(@denominador, @numerador)
    end

    # Calcula la suma de dos fracciones.
    def +(other) # Calcula la suma de dos fracciones.
        if other.class == Frac
            Frac.new(@numerador*other.denominador + other.numerador*@denominador , @denominador*other.denominador)
        elsif other.class == Fixnum
            Frac.new(@numerador + other*@denominador , @denominador)
        end
                
    end

    # Calcula la resta de dos fracciones.
    def -(other) # Calcula la resta de dos fracciones.
        if (other.class == Frac)
            Frac.new(@numerador*other.denominador - other.numerador*@denominador , @denominador*other.denominador)
        else
        	Frac.new(@numerador - other*@denominador , @denominador)
        end
    end

    # Calcula la multiplicacion de dos fracciones.
    def *(other) # Calcula la multiplicacion de dos fracciones.
    	if other.class == Frac
            Frac.new(@numerador * other.numerador, @denominador * other.denominador)
        elsif other.class == Fixnum
            Frac.new(@numerador * other, @denominador)
        end
    end

    # Calcula la division de dos fracciones.
    def /(other) # Calcula la division de dos fracciones.
        Frac.new(@numerador * other.denominador, @denominador * other.numerador)
    end

    # Calcula el resto al dividir dos fracciones (modulo)
    def %(other) # Calcula el resto al dividir dos fracciones (modulo)
        result = self./(other)
        result = (result.numerador%result.denominador).to_i
    end

    # Se define el metodo coerce para operar enteros con fracciones.
    def coerce(other) # Se define el metodo coerce para operar enteros con fracciones.
    	[self,other]
    end
end

# Metodo que calculo el maximo comun divisor de dos numeros.
def gcd(u, v) # Metedo que calculo el maximo comun divisor de dos numeros.
  u, v = u.abs, v.abs
  while v != 0
    u, v = v, u % v
  end
  u
end

# Trabajo con la clase:
if __FILE__ == $0

include LppT04Matrix

m1 = MatrizDensa.new(2,2,[[1,2],[3,4]])
m2 = MatrizDispersa.new(2, 2, {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}})
m3 = MatrizDensa.new(2,2,[[7,10],[15,22]])
m4 = MatrizDispersa.new(2, 2, {0 => {0 => Frac.new(1,2), 1 => Frac.new(1,2)}, 1 => {0 => Frac.new(1,2), 1 => Frac.new(1,2)}})
a = Frac.new(1,2)
b = Frac.new(2,2)
c = Frac.new(3,2)
d = Frac.new(4,2)
e = Frac.new(3,2)
f = Frac.new(9,2)
g = Frac.new(3,1)
h = Frac.new(6,1)
m9 = MatrizDensa.new(2,2,[[a,b],[c,d]])
m10 = MatrizDensa.new(2,2,[[e,3],[f,6]])
puts m9-(m1)
puts
puts m1-(m9)
puts 
puts m4.to_s
puts m4*m1
puts m1*m4
puts m1*m1
puts (m2*m4).to_s
puts (m4*m2).to_s
puts m1
end