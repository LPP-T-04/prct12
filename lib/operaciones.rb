$:.unshift File.dirname(__FILE__) + '/../lib'
require 'lpp_t_04_matrix'
include  LppT04Matrix

class Operaciones

	Densa = "Densa"
  	Dispersa = "Dispersa"
  	attr_accessor :cont

	def initialize(name = "", &block)
		@cont = 0
		@valor = ""
		instance_eval &block
		
	end
	def operacion(tipo,lista)
		vector = Array.new
		matrices = lista.each {|key, value| vector << matriz(key,value)}
		acumulado = vector.pop()
		case tipo
		when "suma"
			valor = vector.each{|a| acumulado = a + acumulado}
		when "resta"
			valor = vector.each{|a| acumulado = a - acumulado}
		when "multipliacion"
			valor = vector.each{|a| acumulado = a * acumulado}
		end
		@valor  << tipo  << "\n" << acumulado.to_s.to_s << "\n"
	end
	def densa(f,c)
		@cont = @cont + 1;
		[@cont,"Densa",f,c]
	end
	def dispersa(f,c)
		@cont = @cont + 1;
		[@cont,"Dispersa",f,c]
	end
	def matriz(tipo,valor)
		if tipo[1] == "Densa"
			return MatrizDensa.new(tipo[2],tipo[3],valor)
		end
		if tipo[1] == "Dispersa"
			return MatrizDispersa.new(tipo[2],tipo[3],valor)
		end
	end
	def to_s
		@valor
	end
end



if __FILE__ == $0
	prueba = Operaciones.new() do
		operacion "suma",
		densa(2,2) =>[[1,2],[3,4]],
		densa(2,2) =>[[5,6],[7,8]],
		densa(2,2) =>[[1,2],[3,4]],
		dispersa(2, 2) => {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}}

		operacion "resta",
		densa(2,2) =>[[1,2],[3,4]],
		densa(2,2) =>[[5,6],[7,8]],
		densa(2,2) =>[[1,2],[3,4]],
		dispersa(2, 2) => {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}}

		operacion "multipliacion",
		densa(2,2) =>[[1,2],[3,4]],
		dispersa(2, 2) => {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}}
	end
end