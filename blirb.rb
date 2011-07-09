require 'irb'
require './blirb_object'
class Blirb
  class ::Object
    include BlirbObject
  end

  def initialize tasks=nil
    @tasks = tasks
    @current_task = nil
  end

  def go
    menu
    IRB.start
  end

  private
  def integer? n
    n =~ /^\d+\Z/
  end

  def current_task=(task)
    @current_task = task
    Object.class_eval do
      @current_task = task
    end
  end

  # does the prompt, sets the current task
  def menu
    puts "please choose a task by entering task number:\n"
    @tasks.each_with_index do |task, index|
      puts "#{index} - #{task.description}" unless task.passed?
    end
    while true
      print "> "
      if integer?( (selection = gets.chomp) ) && @tasks[(selection = selection.to_i)]
        self.current_task = @tasks[selection]
        puts "cool, task #{selection}. Let's get started."
        break
      else
        puts "wtf are you trying to pull? i said make a choice, mofo!!"
      end
    end
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
    puts "calling test"
    result = eval(test,b)
    puts "result was: #{result}"
  end

  def passed?
    @passed
  end

  private
  def pass!
    @passed = true
  end
end

if __FILE__ == $0
  t = Task.new "set a variable 'dude' with a value... any value.", %{ 
    return true if defined? dude
    false
  }

  #initialize with list of tasks
  blirb = Blirb.new([t])
  blirb.go
end
