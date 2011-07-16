require 'test/unit'
require_relative 'test_helper'
class BlirbCoordinatorTest < Test::Unit::TestCase
  
 def test_blirb_coordinator_basics
  bc = BlirbCoordinator.new
  assert_equal 2, bc.tasks.length, "bc should have tasks"
  assert Object.class_eval { @blirb }, "bc should set Object class variable"
  
  bc = BlirbCoordinator.new 'test/fixtures/tasks.yml'
  assert_equal 1, bc.tasks.length
 end
  
  
  
end