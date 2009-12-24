libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

module Spacewar
  VERSION = '0.0.1'
  ROOT = File.dirname(__FILE__)
end

require 'spacewar/spacewar'