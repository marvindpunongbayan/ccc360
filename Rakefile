# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'rake/testtask'
require 'rdoc/rdoc'
require 'rdoc/task'

require 'bundler/gem_tasks'
require 'rubygems/package_task'



# initialize Gem Speificiation file
spec = eval(File.read('ccc360.gemspec'))

Rake::TestTask.new do |t|
	t.libs << "test"
	t.test_files = FileList['test/*/**.rb']
end

=begin
Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

RDoc::Task.new do |rdoc|
	rdoc.main = "README.md"
  rdoc.rdoc_files.include("README.md", "lib   /*.rb")
end

=end

task :default => ["test"]

