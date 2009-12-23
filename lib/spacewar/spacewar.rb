# require 'rubygems'
require 'gosu'
require 'chingu'

include Gosu
include Chingu

module Spacewar
  VERSION = '0.0.1'
  
  DEBUG = false
  G_CONST = 2000

  SCREEN_WIDTH = 1280
  SCREEN_HEIGHT = 800
  
  #
  # A minimalistic Chingu example.
  # Chingu::Window provides #update and #draw which calls corresponding methods for all objects based on Chingu::Actors
  #
  # Image["picture.png"] is a deployment safe shortcut to Gosu's Image.new and supports multiple locations for "picture.png"
  # By default current dir, media\ and gfx\ is searched. To add own directories:
  #
  # Image.autoload_dirs << File.join(self.root, "data", "my_image_dir")  
  #
  class Game < Chingu::Window
    def initialize
      super(SCREEN_WIDTH,SCREEN_HEIGHT)
      self.input = {:esc => :exit}
      @planet = Planet.create

      @player1 = Player.create({:holding_right=>:turn_right, :holding_left=>:turn_left, :holding_up=>:accelerate}, :zorder => 2, :x=>180, :y=>240, :image => 'Starfighter_p1.bmp')
      @player2 = Player.create({:holding_d=>:turn_right, :holding_a=>:turn_left, :holding_w=>:accelerate}, :zorder => 2, :x=>400, :y=>240, :image => 'Starfighter_p2.bmp')
      @score = 0
      @score_text = Chingu::Text.create("Score: #{@score}", :x => 10, :y => 10, :zorder => 55, :size=>20)
    end

    def update
      super

      if rand(100) < 4 && Star.all.size < 25
        Star.create
      end

      #
      # Collide @player with all instances of class Star
      #
      @player1.each_collision(Star) do |player, star| 
        star.destroy
        @score+=10
      end

      @player2.each_collision(Star) do |player, star|
        star.destroy
        @score-=5
      end

      @player1.adjust_gravity(@planet)
      @player2.adjust_gravity(@planet)

      Star.all.each{|star| star.adjust_gravity(@planet)}

      @player1.each_collision(Player) do |player1, player2|
        if player2 == @player2
          player1.destroy
          player2.destroy
          @player1 = Player.create({:holding_right=>:turn_right, :holding_left=>:turn_left, :holding_up=>:accelerate}, :zorder => 2, :x=>180, :y=>240, :image => 'Starfighter_p1.bmp')
          @player2 = Player.create({:holding_d=>:turn_right, :holding_a=>:turn_left, :holding_w=>:accelerate}, :zorder => 2, :x=>400, :y=>240, :image => 'Starfighter_p2.bmp')
        end
      end

      @planet.each_collision(Player) do |planet, player| 
        player.destroy
        @score-=10000
      end

      @score_text.text = "Score: #{@score}"
      self.caption = "Chingu Game - " + @score_text.text
    end
  end

  # extend game object with gravity features
  class Chingu::GameObject
    def adjust_gravity(source)
      # Calculate vector to source
      vect_x = -(self.x - source.x)
      vect_y = -(self.y - source.y)

      # Get length of vector to source
      length = (vect_x**2 + vect_y**2)**0.5

      # Calculate unit vector
      vect_x = vect_x/length
      vect_y = vect_y/length

      # Diminish unit vector as 1/r**2
      vect_x *= (1/length ** 2)
      vect_y *= (1/length ** 2)

      # Scale to strength of gravity and apply
      self.velocity_x += vect_x * G_CONST
      self.velocity_y += vect_y * G_CONST
    end
  end

  class Player < Chingu::GameObject
    has_trait :bounding_circle, :debug => DEBUG
    has_traits :collision_detection, :effect, :velocity

    def initialize(input, options={})
      super(options)
      @image = Image[options[:image]]
      self.input = input
      self.max_velocity = 1
    end

    def accelerate
      self.velocity_x += Gosu::offset_x(self.angle, 0.5)*self.max_velocity
      self.velocity_y += Gosu::offset_y(self.angle, 0.5)*self.max_velocity
    end

    def turn_right
      # The same can be achieved without trait 'effect' as: self.angle += 4.5
      rotate(4.5)
    end

    def turn_left
      # The same can be achieved without trait 'effect' as: self.angle -= 4.5
      rotate(-4.5)
    end

    def update

      self.velocity_x *= 0.99 # dampen the movement
      self.velocity_y *= 0.99

      @x %= $window.width # wrap around the screen
      @y %= $window.height
    end
  end

  class Planet < Chingu::GameObject
    has_trait :bounding_circle, :debug => true
    has_trait :collision_detection

    def initialize(options={})
      super(:zorder=>1)
      @image = Image["planet.png"]
      self.color = Gosu::Color.new(0xff000000)
      self.color.red = rand(255 - 40) + 40
      self.color.green = rand(255 - 40) + 40
      self.color.blue = rand(255 - 40) + 40
      self.x = $window.width/2
      self.y = $window.height/2

      cache_bounding_circle
    end
  end

  class Star < Chingu::GameObject
    has_trait :bounding_circle, :debug => DEBUG
    has_traits :collision_detection, :velocity

    def initialize(options={})
      super(:zorder=>1)
      @animation = Chingu::Animation.new(:file => media_path("Star.png"), :size => [25,25])
      @image = @animation.next
      self.color = Gosu::Color.new(0xff000000)
      self.color.red = rand(255 - 40) + 40
      self.color.green = rand(255 - 40) + 40
      self.color.blue = rand(255 - 40) + 40
      self.x =rand * $window.width
      self.y =rand * $window.height
      self.velocity_x = rand(10)
      self.velocity_y = rand(10)

      #
      # A cached bounding circle will not adapt to changes in size, but it will follow objects X / Y
      # Same is true for "cache_bounding_box"
      #
      cache_bounding_circle
    end

    def update
      @x %= $window.width # wrap around the screen
      @y %= $window.height

      # Move the animation forward by fetching the next frame and putting it into @image
      # @image is drawn by default by GameObject#draw
      @image = @animation.next
    end
  end
end

Spacewar::Game.new.show