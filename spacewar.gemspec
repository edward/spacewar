Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  
  s.name = 'spacewar'
  s.version = "0.0.1"
  s.date = '2009-12-23'
  
  s.description = 'There are two spaceships, a planet, gravity, missiles, and lasers. Do the math.'
  s.summary = 'A brave group-effort by the gentlemen at Ottawa.rb (aka OGRE), spacewar is a legitimate heir to the glory that is the original game you likely played on an xt or more ancient beast of a machine.'

  s.authors = ["Edward Ocampo-Gooding", "John Duff", "Justin Bowes", "Chris Saunders", "Schwab", "Pranav Singh", "Dwayne Litzenberger", "Jean Claude Batista"]
  s.email = 'edward@edwardog.net'
  
  # = MANIFEST =
  s.files = %w[
    LICENSE
    README
    README.rdoc
    Rakefile
    VERSION
    bin/spacewar
    lib/Media/Parallax-scroll-example-layer-0.png
    lib/Media/Parallax-scroll-example-layer-1.png
    lib/Media/Parallax-scroll-example-layer-2.png
    lib/Media/Parallax-scroll-example-layer-3.png
    lib/Media/Star.png
    lib/Media/Starfighter.bmp
    lib/Media/Starfighter_p1.bmp
    lib/Media/Starfighter_p2.bmp
    lib/Media/background1.png
    lib/Media/bullet.png
    lib/Media/bullet_hit.wav
    lib/Media/circle.png
    lib/Media/city1.csv
    lib/Media/city1.png
    lib/Media/city2.png
    lib/Media/droid.bmp
    lib/Media/enemy_bullet.png
    lib/Media/explosion.wav
    lib/Media/fire_bullet.png
    lib/Media/fireball.png
    lib/Media/laser.wav
    lib/Media/particle.png
    lib/Media/plane.csv
    lib/Media/plane.png
    lib/Media/planet.png
    lib/Media/rect.png
    lib/Media/ruby.png
    lib/Media/saucer.csv
    lib/Media/saucer.gal
    lib/Media/saucer.png
    lib/Media/spaceship.png
    lib/Media/stickfigure.bmp
    lib/Media/stickfigure.png
    lib/Media/video_games.png
    lib/Media/wood.png
    lib/spacewar.rb
    space_war.rb
    test/helper.rb
    test/test_spacewar.rb
  ]
  # = MANIFEST =
  
  s.test_files = s.files.select {|path| path =~ /^test\/.*_test.rb/}
  
  s.extra_rdoc_files = %w[README.rdoc LICENSE]
  s.add_dependency(%q<chingu>, [">= 0.6.7"])
  
  s.has_rdoc = true
  s.homepage = 'http://github.com/edward/spacewar'
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Spacewar", "--main", "README.rdoc", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = '1.3.5'
end