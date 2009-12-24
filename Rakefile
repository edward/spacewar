require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'fileutils'
require 'lib/spacewar'

include FileUtils

version = Spacewar::VERSION
name = "spacewar"

spec = Gem::Specification.new do |s|
	s.name = name
	s.version = version
  s.summary = 'There are two spaceships, a planet, gravity, missiles, and lasers. Do the math.'
  s.description = 'A brave group-effort by the gentlemen at Ottawa.rb (aka OGRE), spacewar is a legitimate heir to the glory that is the original game you likely played on an xt or more ancient beast of a machine.'
	s.authors = ["Edward Ocampo-Gooding", "John Duff", "Justin Bowes", "Chris Saunders", "Schwab", "Pranav Singh", "Dwayne Litzenberger", "Jean Claude Batista"]
  
	s.email = 'edward@edwardog.net'
	s.homepage = "http://github.com/edward/spacewar"
	s.executables = [ "spacewar" ]
	s.default_executable = "spacewar"
	s.rubyforge_project = "spacewar"

	s.platform = Gem::Platform::RUBY
	s.has_rdoc = false
	
	s.files = %w(Rakefile) +
		Dir.glob("{bin,lib,test}/**/*")
	
	s.require_path = "lib"
	s.bindir = "bin"

	s.add_dependency('chingu', '>= 0.6.7')
end

Rake::GemPackageTask.new(spec) do |p|
	p.need_tar = true if RUBY_PLATFORM !~ /mswin/
end

desc "Install #{name} gem (#{version})"
task :install => [ :test, :package ] do
	sh %{sudo gem install pkg/#{name}-#{version}.gem}
end

desc "Uninstall #{name} gem"
task :uninstall => [ :clean ] do
	sh %{sudo gem uninstall #{name}}
end