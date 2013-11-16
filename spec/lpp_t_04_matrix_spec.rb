require 'spec_helper'
include  LppT04Matrix

describe LppT04Matrix do
	
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
end
