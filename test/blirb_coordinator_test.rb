require 'test/unit'
require_relative 'test_helper'
class BlirbCoordinatorTest < Test::Unit::TestCase
  def setup
    @tasks = []
    @tasks << Task.new("set an instance variable 'dude' with a value... any value.", %{ 
      defined?(@dude) ? true : false
    })
    @blirb = BlirbCoordinator.new @tasks
  end
  
  def test_a_blirb_has_tasks
    assert @blirb.tasks
    assert_equal 1, @blirb.tasks.count
  end
end