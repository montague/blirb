require 'test/unit'
require_relative 'test_helper'
class TaskTest < Test::Unit::TestCase
  def setup
    @task = Task.new("set an instance variable 'dude' with a value... any value.", %{ 
      defined?(@dude) ? true : false
    })
  end
  
  def test_testing_a_task
    assert !@task.test!(binding), "Testing should fail if task hasn't been completed"
    assert !@task.passed?, "Tasks should start out not passed"
    
    @dude = 4
    
    assert @task.test!(binding), "Testing should pass if task has been completed"
    assert @task.passed?, "Task should pass itself when tested successfully"
  end

end