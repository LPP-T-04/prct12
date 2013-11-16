require 'spec_helper'
include  LppT04Matrix

describe LppT04Matrix do
	before :all do
		@m1 = Matriz.new(2,2)
	end
	describe Matriz do
		describe "Se comprueba el numero de:" do
			it "filas de la matriz" do
				@m1.filas.should eq(2)  
			end
			it "columnas de la matriz" do
				@m1.columnas.should eq(2)  
			end
		end
	end
	describe MatrizDensa do
	end
	describe MatrizDispersa do
	end
end
