require "lpp_t_04_matrix/version"

module LppT04Matrix
	class Matriz
	  	attr_accessor :filas, :columnas
	  	def initialize (filas, columnas)
	  		@filas = filas
	  		@columnas = columnas
	  	end
	end

	class MatrizDensa < Matriz
		attr_accessor :elemento
		def initialize (filas, columnas, elemento)
			super(filas, columnas)
			@elemento = elemento
		end

		def [](i)
			@elemento[i]
 		end

 		def indice(i,j)
 			@elemento[i][j]
 		end

		def to_s
			imprimir = ""
			@filas.times do |i|
				@columnas.times do |j|
					imprimir << "#{elemento[i][j]} "
				end
				imprimir << "\n"
			end
			imprimir
		end

		def +(other)
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

		def -(other)
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

		def *(other)
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

		def traspuesta
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
	end


	class MatrizDispersa < Matriz
		attr_accessor :elemento
		def initialize (filas, columnas, elemento)
			super(filas, columnas)
    		@elemento = elemento
		end

		def [](i)
			@elemento[i]
 		end
 		def indice(i,j)
 			elemento = @elemento.fetch(i,0)
 			if elemento!= 0
 				elemento.fetch(j,0)
 			else
 				0
 			end
 		end

		def to_s
			@elemento
		end
		
		def +(other)
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

		def -(other)
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

		def *(other)
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

		def traspuesta
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
	end
end

class Frac
	attr_reader :numerador, :denominador # Se definen set y get para acceder a las variables de la clase.
	include Comparable # Se incluye el modulo de nombre "comparable" utilizado para el operador <=>.
	
    def initialize(numerador, denominador) # Se define el constructor.
		mcd = gcd(numerador,denominador)
		@numerador , @denominador = numerador/mcd, denominador/mcd
	end
	
    def num() # Devuelve el numerador.
		@numerador
	end
	
    def denom() # Devuelve el denominador.
		@denominador
	end
	
    def to_s
        if @denominador == 1 #Si el denominador es 1, solo se imprimer el numerador
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
	
    def to_f() # Imprime el resultado de la fraccion como un float.
		@numerador.to_f/@denominador
	end
	
    def <=>(other) # Se define el operador <=> para el modulo comparable.
    	@numerador.to_f/@denominador <=> other.numerador.to_f/other.denominador
    end
    
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
    
    def reciprocal() # Calcula el reciproco de una fraccion.
    	Frac.new(@denominador, @numerador)
    end

    def +(other) # Calcula la suma de dos fracciones.
        if other.class == Frac
            Frac.new(@numerador*other.denominador + other.numerador*@denominador , @denominador*other.denominador)
        elsif other.class == Fixnum
            Frac.new(@numerador + other*@denominador , @denominador)
        end
                
    end

    def -(other) # Calcula la resta de dos fracciones.
        if (other.class == Frac)
            Frac.new(@numerador*other.denominador - other.numerador*@denominador , @denominador*other.denominador)
        else
        	Frac.new(@numerador - other*@denominador , @denominador)
        end
    end

    def *(other) # Calcula la multiplicacion de dos fracciones.
    	if other.class == Frac
            Frac.new(@numerador * other.numerador, @denominador * other.denominador)
        elsif other.class == Fixnum
            Frac.new(@numerador * other, @denominador)
        end
    end

    def /(other) # Calcula la division de dos fracciones.
        Frac.new(@numerador * other.denominador, @denominador * other.numerador)
    end

    def %(other) # Calcula el resto al dividir dos fracciones (modulo)
        result = self./(other)
        result = (result.numerador%result.denominador).to_i
    end

    def coerce(other)
    	[self,other]
    end
end

def gcd(u, v)
  u, v = u.abs, v.abs
  while v != 0
    u, v = v, u % v
  end
  u
end

if __FILE__ == $0
# Trabajo con la clase:
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

end