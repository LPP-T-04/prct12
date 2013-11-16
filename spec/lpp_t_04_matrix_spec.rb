require 'spec_helper'
include  LppT04Matrix

describe LppT04Matrix do

	describe Matriz do
		before :all do
			@m1 = Matriz.new(2,2)
		end
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
		before :all do
			@m1 = MatrizDensa.new(2,2,[[1,2],[3,4]])
		end
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

		describe "Imprimir la matriz" do
			it "del orden 2x2" do
				@m1.to_s.should eq("1 2 \n3 4 \n")
			end
		end
	end

	describe MatrizDispersa do
		before :all do
			@m1 = MatrizDispersa.new(250, 250, {100 => {10 => 1, 50 => 200}, 200 => {10 => 1, 50 => 200}})
		end
		describe "Acceder al subindice;" do
			it "Para acceder al [0,0]" do
				@m1.elemento[100][10].should eq(1)
			end
			it "Para acceder al [0,0]" do
				@m1.elemento[100][50].should eq(200)
			end
			it "Para acceder al [0,0]" do
				@m1.elemento[200][10].should eq(1)
			end
			it "Para acceder al [0,0]" do
				@m1.elemento[200][50].should eq(200)
			end
		end
	end
end
