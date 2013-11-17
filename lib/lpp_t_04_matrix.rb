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
	end

	class MatrizDispersa < Matriz
		attr_accessor :elemento
		def initialize (filas, columnas, elemento)
			super(filas, columnas)
			@elemento = elemento
		end

		def to_s
			elemento
		end
		
		def +(other)
			raise ArgumentError, "La longitud de las matrices no coincide." unless @filas == other.filas && @columnas == other.columnas
			elemento = @elemento.merge(other.elemento){|key, oldval, newval| oldval.merge(newval){|key2, oldval2, newval2|oldval2 + newval2}}
			MatrizDispersa.new(@filas, other.columnas, elemento)
		end
	end
end
