Dir.chdir File.expand_path('../..', __FILE__) #for textmate's cmd+R
require_relative '../lib/blirb'
require 'test/unit'
class Test::Unit::TestCase
  include Blirb
end

class TaskTester
  TASKS_TO_VERIFY = 'blirb_tasks/tasks.rb'
  
  attr_reader :tasks
  def initialize(file_path=nil)
    file_path ||= TASKS_TO_VERIFY
    @tasks = []
    eval File.read(file_path)
  end
  
  # used for task definistions in blirb_tasks/tasks.rb
  def task description, test_code, validation_code
    @tasks << ::Blirb::Task.new(description, test_code, validation_code)
  end
end