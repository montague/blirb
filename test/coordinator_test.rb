require_relative 'test_helper'
class CoordinatorTest < Test::Unit::TestCase
  
 def test_coordinator_basics
  bc = Coordinator.new
  assert_equal 2, bc.tasks.length, "bc should have tasks"
  assert Object.class_eval { @blirb }, "bc should set Object class variable"
  
  bc = Coordinator.new 'test/fixtures/tasks.yml'
  assert_equal 1, bc.tasks.length
 end
  
  
  
end