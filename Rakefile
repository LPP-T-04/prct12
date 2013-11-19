require "bundler/gem_tasks"
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :test

task :test => :spec do
  sh "ruby -Ilib -Itest test/tc_lpp_t_04_matrix.rb"
end