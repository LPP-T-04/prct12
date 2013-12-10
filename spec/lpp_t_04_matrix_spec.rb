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
			@m2 = MatrizDensa.new(2,2,[[2,4],[6,8]])
			@m3 = MatrizDensa.new(2,2,[[7,10],[15,22]])
			@m4 = MatrizDensa.new(2,2,[[1,3],[2,4]])
			a = Frac.new(1,2)
			b = Frac.new(2,2)
			c = Frac.new(3,2)
			d = Frac.new(4,2)
			@m9 = MatrizDensa.new(2,2,[[a,b],[c,d]])
			@m10 = MatrizDensa.new(2,2,[[0,0],[0,0]])
			@m11 = MatrizDensa.new(2,2,[[a,c],[b,d]])
			e = Frac.new(7,4)
			f = Frac.new(10,4)
			g = Frac.new(15,4)
			h = Frac.new(22,4)
			@m12 = MatrizDensa.new(2,2,[[e,f],[g,h]])
			i = Frac.new(3,2)
			j = Frac.new(9,2)
			k = Frac.new(-1,2)
			l = Frac.new(-3,2)
			@m13 = MatrizDensa.new(2,2,[[i,3],[j,6]])
			@m14 = MatrizDensa.new(2,2,[[k,-1],[l,-2]])

			@m15 = MatrizDensa.new(2,2,[[Frac.new(7,2),5],[Frac.new(15,2),11]])

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
		describe "Suma de dos matrices" do
			it "del orden mxn" do
				@m1.+(@m1).to_s.should eq(@m2.to_s)
			end
		end
		describe "Suma de matrices de fracciones y enteros" do
			it "del orden mxn" do
				@m9.+(@m1).to_s.should eq(@m13.to_s)
			end
		end
		describe "Suma de matrices de enteros y fracciones" do
			it "del orden mxn" do
				@m1.+(@m9).to_s.should eq(@m13.to_s)
			end
		end
		describe "Resta de dos matrices" do
			it "del orden mxn" do
				@m2.-(@m1).to_s.should eq(@m1.to_s)
			end
		end
		describe "Resta de matrices de fracciones y enteros" do
			it "del orden mxn" do
				@m9.-(@m1).to_s.should eq(@m14.to_s)
			end
		end
		describe "Resta de matrices de enteros y fracciones" do
			it "del orden mxn" do
				@m1.-(@m9).to_s.should eq(@m14.to_s)
			end
		end
		describe "Matriz traspuesta " do
			it "del orden nxn." do
				@m1.traspuesta.to_s.should eq(@m4.to_s)
			end
		end

		describe "Multiplicacion de matrices del orden axn x nxb" do
			it "del orden 2x2 x 2x2" do
				@m1.*(@m1).to_s.should eq(@m3.to_s)
			end
		end
		describe "Multiplicacion de matrices de fracciones y enteros" do
			it "del orden mxn" do
				@m9.*(@m1).to_s.should eq(@m15.to_s)
			end
		end
		describe "Multiplicacion de matrices de enteros y fracciones" do
			it "del orden mxn" do
				@m1.*(@m9).to_s.should eq(@m15.to_s)
			end
		end
		describe "Trabajo con fracciones" do
			it "suma" do
				@m9.+(@m9).to_s.should eq (@m1.to_s)
			end
			it "resta" do
				@m9.-(@m9).to_s.should eq (@m10.to_s)
			end
			it "Multiplicacion" do
				@m9.*(@m9).to_s.should eq (@m12.to_s)
			end
			it "traspuesta" do
				@m9.traspuesta.to_s.should eq (@m11.to_s)
			end
		end
		describe "Calculo de maximo y minimo" do
			it "Maximo" do
				@m1.maximo.should eq (4)
			end
			it "Minimo" do
				@m1.minimo.should eq (1)
			end
		end
	end

	describe MatrizDispersa do
		before :all do
			@m1 = MatrizDispersa.new(250, 250, {100 => {10 => 1, 50 => 200}, 200 => {10 => 1, 50 => 200}})
			@m2 = MatrizDispersa.new(250, 250, {100 => {10 => 2, 50 => 400}, 200 => {10 => 2, 50 => 400}})
			@m3 = MatrizDispersa.new(2, 2, {1 => {1 => 1, 2 => 2}, 2 => {1 => 3, 2 => 4}})
			@m4 = MatrizDispersa.new(2, 2, {1 => {1 => 7, 2 => 10}, 2 => {1 => 15, 2 => 22}})
			@m5 = MatrizDispersa.new(2, 2, {1 => {1 => 1, 2 => 3}, 2 => {1 => 2, 2 => 4}})
			@m6 = MatrizDispersa.new(3, 2, {2 => {1 => 1}, 3 => { 2 => 4}})
			@m7 = MatrizDispersa.new(2, 3, {1 => {2 => 6}, 2 => {1 => 7}})
			@m8 = MatrizDispersa.new(3, 3, {2=>{2=>6}, 3=>{1=>28}})
			
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

		describe "Imprimir la matriz" do
			it "del orden 250x250" do
				@m1.to_s.should eq({100=>{10=>1, 50=>200}, 200=>{10=>1, 50=>200}})
			end
		end

		describe "Suma de dos matrices" do
			it "del orden mxn" do
				@m1.+(@m1).to_s.should eq(@m2.to_s)
			end
		end	

		describe "Resta de dos matrices" do
			it "del orden mxn" do
				@m2.-(@m1).to_s.should eq(@m1.to_s)
			end
		end	

		describe "Multiplicacion de matrices del orden axn x nxb" do
			it "del orden 2x2 x 2x2" do
				@m3.*(@m3).to_s.should eq(@m4.to_s)
			end
			it "del orden 3x2 x 2x3" do
				@m6.*(@m7).to_s.should eq(@m8.to_s)
			end
		end

		describe "Matriz traspuesta " do
			it "del orden nxn." do
				@m3.traspuesta.to_s.should eq(@m5.to_s)
			end
		end
		describe "Calculo de maximo y minimo" do
			it "Maximo" do
				@m1.maximo.should eq (200)
			end
			it "Minimo" do
				@m1.minimo.should eq (1)
			end
		end
	end

	before :all do
		@m1 = MatrizDensa.new(2,2,[[1,2],[3,4]])
		@m2 = MatrizDispersa.new(2, 2, {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}})
		@m3 = MatrizDensa.new(2,2,[[7,10],[15,22]])
		@m4 = MatrizDensa.new(2,2,[[2,4],[6,8]])
		@m5 = MatrizDensa.new(2,2,[[0,0],[0,0]])
		@m6 = MatrizDispersa.new(2, 2, {0 => {0 => Frac.new(1,2), 1 => Frac.new(1,2)}, 1 => {0 => Frac.new(1,2), 1 => Frac.new(1,2)}})
		@m7 = MatrizDensa.new(2,2,[[Frac.new(3,2),Frac.new(3,2)],[Frac.new(7,2),Frac.new(7,2)]])
	end

	describe "Trabajo con  matrices de diferente tipo" do
		describe "Matriz Densa -> Matriz Dispersa" do
			it "Suma de dos matrices del orden mxn" do
				@m1.+(@m2).to_s.should eq(@m4.to_s)
			end
			it "Resta de dos matrices del orden mxn" do
				@m1.-(@m2).to_s.should eq(@m5.to_s)
			end
			it "Multiplicacion del orden 2x2 x 2x2" do
				@m1.*(@m2).to_s.should eq(@m3.to_s)
			end
			it "Multiplicacion del orden 2x2 x 2x2 con fracciones y enteros" do
				@m1.*(@m6).to_s.should eq(@m7.to_s)
			end
		end
	end

	describe "Trabajo con  matrices de diferente tipo" do
		describe "Matriz Dispersa -> Matriz Densa" do
			it "Suma de dos matrices del orden mxn" do
				@m2.+(@m1).to_s.should eq(@m4.to_s)
			end
			it "Resta de dos matrices del orden mxn" do
				@m2.-(@m1).to_s.should eq(@m5.to_s)
			end
			it "Multiplicacion del orden 2x2 x 2x2" do
				@m2.*(@m1).to_s.should eq(@m3.to_s)
			end
			it "Multiplicacion del orden 2x2 x 2x2 con fracciones y enteros" do
				@m6.*(@m1).to_s.should eq(@m7.to_s)
			end
		end
	end
	describe "Funcion encotrar propuesta en la practica" do
		it "El cuadrado del valor debe ser mayor que 6" do
			(@m1.encontrar(){|x| x*x > 6}).should eq([[1,0],[1,1]])
		end
		it "El cuadrado del valor debe ser mayor que 6" do
			(@m2.encontrar(){|x| x*x > 6}).should eq([[1,0],[1,1]])
		end
	end
end

describe "DDL" do
	before :all do
		@pruebaSuma = Operaciones.new() do
			operacion "suma",
			densa(2,2) =>[[1,2],[3,4]],
			dispersa(2, 2) => {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}}
		end
		@pruebaResta= Operaciones.new() do
			operacion "resta",
			densa(2,2) =>[[1,2],[3,4]],
			dispersa(2, 2) => {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}}
		end

		@pruebaMultiplicacion= Operaciones.new() do
			operacion "multipliacion",
			densa(2,2) =>[[1,2],[3,4]],
			dispersa(2,2) => {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}}
		end


	end
	it "Suma" do
		@pruebaSuma.to_s.should eq("suma\n2 4 \n6 8 \n\n")
	end
	it "Resta" do
		@pruebaResta.to_s.should eq("resta\n0 0 \n0 0 \n\n")
	end
	it "Multiplicacion" do
		@pruebaMultiplicacion.to_s.should eq("multipliacion\n7 10 \n15 22 \n\n")
	end
end