require "lpp_t_04_matrix/version"

module LppT04Matrix
  class Matriz
  	attr_accessor :filas, :columnas
  	def initialize (filas, columnas)
  		@filas = filas
  		@columnas = columnas
  	end
  end
end
