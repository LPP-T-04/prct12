# LppT04Matrix

:~/LPP/prct09/tree
.
├── Gemfile
├── Gemfile.lock
├── Guardfile
├── lib
│   ├── lpp_t_04_matrix
│   │   └── version.rb
│   └── lpp_t_04_matrix.rb
├── LICENSE.txt
├── lpp_t_04_matrix.gemspec
├── Rakefile
├── README.md
└── spec
    ├── lpp_t_04_matrix_spec.rb
    └── spec_helper.rb


Jerarquia de clases para la creación las matrices:

Se definirá una clase para matrices densas en la que se definirán sus métodos.  
Se definirá una clase para matrices dispersas que heredará de matrices densas y se redefinirán los metodos necesarios para trabajar con este tipo de matrices.  
class Matriz_densa  
Class Matriz_dispersa < Matriz_densa

## Installation

Add this line to your application's Gemfile:

    gem 'lpp_t_04_matrix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lpp_t_04_matrix

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
