#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__) + '/../lib'

filename = ARGV.shift 

exam =  File.open(filename).read
exam = <<"EXAM"
  require 'operaciones'

  Operaciones.new() do
    #{exam}
  end
EXAM
puts "************************"
quiz =  eval exam
puts quiz