dir = File.dirname(__FILE__)
require "#{dir}/lib/active_queue/version"

PKG_BUILD     = ENV['PKG_BUILD'] ? '.' + ENV['PKG_BUILD'] : ''
PKG_NAME      = 'activequeue'
PKG_VERSION   = ActiveQueue::VERSION::STRING + PKG_BUILD
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"
RELEASE_NAME  = "REL #{PKG_VERSION}"


require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << ["#{dir}/test", "#{dir}/lib"]
  t.test_files = Dir.glob("#{dir}/test/**/*_test.rb").sort
  t.verbose = true
  t.warning = true
  t.ruby_opts = ['-rubygems']
end

namespace :test do
  task :isolated do
    ruby = File.join(*RbConfig::CONFIG.values_at('bindir', 'RUBY_INSTALL_NAME'))
    Dir.glob("#{dir}/test/**/*_test.rb").all? do |file|
      system(ruby, '-w', "-I#{dir}/lib", "-I#{dir}/test", file)
    end or raise "Failures"
  end
end


require 'rake/rdoctask'

# Generate the RDoc documentation
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = "#{dir}/doc"
  rdoc.title    = "Active Queue"
  rdoc.options << '--line-numbers' << '--inline-source' << '-A cattr_accessor=object'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.template = ENV['template'] ? "#{ENV['template']}.rb" : '../doc/template/horo'
  rdoc.rdoc_files.include("#{dir}/README.rdoc", "#{dir}/CHANGES")
  rdoc.rdoc_files.include("#{dir}/lib/**/*.rb")
end


require 'rake/packagetask'
require 'rake/gempackagetask'

spec = eval(File.read("#{dir}/activequeue.gemspec"))

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end
