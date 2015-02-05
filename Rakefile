require 'rubygems'
require 'fileutils'
require 'rake/testtask'
require 'rubygems/package_task'
require './lib/fdprocessor'

task :default => :test

Rake::TestTask.new("test") do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.warning = true
  t.verbose = true
end

spec = Gem::Specification.new do |s| 
  s.name = 'fdprocessor'
  s.version = FDProcessor::VERSION
  s.author = 'Jeff Pace'
  s.email = 'jeugenepace@gmail.com'
  s.homepage = 'http://jeugenepace.github.com/fdprocessor'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A gem for processing files and directories.'
  s.description = 'A gem containing base classes for common processing of files and directories, recursively.'
  s.files = FileList['{bin,lib}/**/*'].to_a
  s.require_path = 'lib'
  s.test_files = FileList['{test}/**/*test.rb'].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = [ 'README.md' ]
  s.license = 'Apache'
end
 
Gem::PackageTask.new(spec) do |pkg| 
  pkg.need_zip = true 
  pkg.need_tar_gz = true 
end 
