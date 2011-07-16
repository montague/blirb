require 'test/unit'
require_relative 'test_helper'
class BlirbCoordinatorTest < Test::Unit::TestCase
  def setup
    @tasks = []
    @tasks << Task.new("set an instance variable 'dude' with a value... any value.", %{ 
      defined?(@dude) ? true : false
    })
    @bc = BlirbCoordinator.new @tasks
  end
  
 def test_blirb_coordinator_setup
  assert_equal 1, @bc.tasks.length, "bc should have tasks"
  assert Object.class_eval { @blirb }, "bc should set Object class variable"
 end
end