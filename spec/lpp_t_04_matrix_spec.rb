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
		describe "Acceder al subindice;" do
			it "Para acceder al [0,0]" do
				@m1.elemento[0][0].should eq(1)
			end
			it "Para acceder al [0,0]" do
				@m1.elemento[0][1].should eq(2)
			end
			it "Para acceder al [0,0]" do
				@m1.elemento[1][0].should eq(3)
			end
			it "Para acceder al [0,0]" do
				@m1.elemento[1][1].should eq(4)
			end
		end
	end
	
	describe MatrizDispersa do
	end
end
