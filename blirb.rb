require 'irb'
require './blirb_object'
class Blirb
  class ::Object
    include BlirbObject
  end
  
  attr_reader :current_task
  
  def initialize tasks
    @tasks = tasks
    @current_task = nil
    blirb = self
    Object.class_eval do
      @blirb = blirb
    end
  end

  def go
    menu
    IRB.start
  end

  # def current_task=(task)
  #   @current_task = task
  #   Object.class_eval do
  #     @current_task = task
  #   end
  # end
  # 
  # def current_task
  #   @current_task
  # end
  # 
  # def go_to_next_task
  #   @current_task.pass!
  #   menu
  # end

  # does the prompt, sets the current task
  def menu
    if !@tasks.any? { |task| !task.passed? }
      puts "thanks for completing the tutorial. come again soon. buh-bye now."
      exit
    end
    puts "please choose a task by entering task number:\n"
    @tasks.each_with_index do |task, index|
      puts "#{index} - #{task.description}" unless task.passed?
    end
    while true
      print "> "
      if integer?( (selection = gets.chomp) ) && @tasks[(selection = selection.to_i)]
        @current_task = @tasks[selection]
        puts "cool, task #{selection}. Let's get started."
        break
      elsif selection == 'q' || selection == 'exit' # variety is the spice of life
        exit
      else
        puts "sorry, i'm not sure what you're trying to do. please do something different."
      end
    end
  end
  
  private
  def integer? n
    n =~ /^\d+\Z/
  end
end

class Task
  attr_reader :test,:description

  def initialize(description, test)
    @description = description
    @passed = false
    @test = test
  end

  def test!(b)
    eval(@test,b)
  end

  def passed?
    @passed
  end

  def pass!
    @passed = true
  end
end

if __FILE__ == $0
  tasks = []
  tasks << Task.new("set a variable 'dude' with a value... any value.", %{ 
    defined?(dude) ? true : false
  })
  tasks << Task.new("set an instance variable 'dude' with a value... any value.", %{ 
    defined?(@dude) ? true : false
  })

  #initialize with list of tasks
  blirb = Blirb.new(tasks)
  blirb.go
end
