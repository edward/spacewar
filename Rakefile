require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "spacewar"
    gem.summary = %Q{A brave group-effort by the gentlemen at Ottawa.rb (aka OGRE), spacewar is a legitimate heir to the glory that is the original game you likely played on an xt or more ancient beast of a machine.}
    gem.description = %Q{There are two spaceships, a planet, gravity, missiles, and lasers. Do the math.}
    gem.email = "edward@edwardog.net"
    gem.homepage = "http://github.com/edward/spacewar"
    gem.authors = ["Edward Ocampo-Gooding, John Duff, Justin Bowes, Chris Saunders, Schwab, Pranav Singh, Dwayne Litzenberger, and Jean Claude Batista"]
    gem.add_dependency('chingu', '>= 0.6.7')
    gem.default_executable = "spacewar"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "spacewar #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
