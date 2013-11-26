require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'rdoc/task'

RSpec::Core::RakeTask.new
task :default => :test

desc "Run Test code examples"
task :test => :spec do
  sh "ruby -Ilib -Itest test/tc_lpp_t_04_matrix.rb"
end


Rake::RDocTask.new do |rd|
   rd.main = "README.md"
   rd.rdoc_files.include("README.md", "lib/**/*.rb")
end