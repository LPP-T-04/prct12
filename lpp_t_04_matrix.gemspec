# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lpp_t_04_matrix/version'

Gem::Specification.new do |spec|
  spec.name          = "lpp_t_04_matrix"
  spec.version       = LppT04Matrix::VERSION
  spec.authors       = ["EliezerCruzSuarez"]
  spec.email         = ["alu0100611298@ull.edu.es"]
  spec.description   = %q{Para realizacion de esta practica se ha creado una jerarquia de clases. 
    Teniendo en cuenta que tenemos una clase abstracta de nombre Matriz, y de la cual han heredado las
    otras dos clases que definen el tipo de objetos que tenemos, MatrizDensa y MatrizDispersa, se han
    implementado los metodos para operar con ambos tipos de matrices, sin importar que objeto sea.
    Además se ha incluido el tratamiento de fracciones desarrollado en la practica anterior con la idea
    de que la matriz sea capaz de operar con elementos del tipo Franction. Los metodos implemnetados son: 
    suma, resta, multiplicacion y traspuesta.}
  spec.summary       = %q{Operacion con matrices densas y dispersas}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 2.9'
end
