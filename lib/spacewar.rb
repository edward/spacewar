libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'spacewar/spacewar'

module Spacewar
  VERSION = '0.0.1'
end