Dir.chdir File.expand_path('../..', __FILE__) #for textmate's cmd+R
require_relative '../lib/blirb'
require 'test/unit'
class Test::Unit::TestCase
  include Blirb
end