require_relative 'test_helper'
class TasksTest < Test::Unit::TestCase
  def setup
    @tester = TaskTester.new
  end
  
  # make sure that each task defined is verifiable
  def test_tasks
   @tester.tasks.each do |task|
    assert task.verify!(binding), task.description
   end
  end
  
end
