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
					elemento_fila << @elemento[i][j] + other.elemento[i][j]
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
			other = other.traspuesta
			raise ArgumentError, "La longitud de las matrices no coincide." unless @columnas == other.filas
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

if __FILE__ == $0
# Trabajo con la clase:
include LppT04Matrix

m1 = MatrizDensa.new(2,2,[[1,2],[3,4]])
m2 = MatrizDispersa.new(2, 2, {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}})
m3 = MatrizDensa.new(2,2,[[7,10],[15,22]])
puts m2+(m1)

end