require 'blirb'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end

class TaskTester
  TASKS_TO_VERIFY = 'blirb_tasks/tasks.rb'
  
  attr_reader :tasks
  def initialize(file_path=nil)
    file_path ||= TASKS_TO_VERIFY
    @tasks = []
    eval File.read(file_path)
  end
  
  # used for task definitions in blirb_tasks/tasks.rb
  def task description, test_code, validation_code
    @tasks << ::Blirb::Task.new(description, test_code, validation_code)
  end
end