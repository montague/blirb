module Blirb
  class Coordinator  
    attr_reader :current_task, :tasks
    DEFAULT_TASKS = 'blirb_tasks/tasks.rb'

    def initialize file_path = nil
      @tasks = []
      load_tasks file_path
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

    # displays menu, sets the current task
    def menu
      end_tutorial if remaining_tasks.empty?
      
      puts "\nplease choose a task by entering task number:\n\n"
      list_tasks
      
      while true
        print "\n> "
        if integer?( (selection = gets.chomp) ) && @tasks[(selection = selection.to_i)]
          select_task selection
          break
        elsif selection == 'q' || selection == 'exit' # variety is the spice of life
          exit
        end
        puts "sorry, i'm not sure what you're trying to do. please do something different."
      end
    end

    private
    def select_task selection
      @current_task = @tasks[selection]
      puts "ok. #{@current_task.description}. Let's get started."
    end
    
    def list_tasks
      @tasks.each_with_index do |task, index|
        puts "#{index} - #{task.description}" unless task.passed?
      end
    end
    
    def end_tutorial
      puts "thanks for completing the tutorial. come again soon. buh-bye now."
      exit
    end
    
    def load_tasks file_path
      eval File.read(file_path || DEFAULT_TASKS)
    end

    def task description, test_code
      @tasks << Task.new(description, test_code)
    end

    def remaining_tasks
      @tasks.select {|task| !task.passed?}
    end

    def integer? n
      n =~ /^\d+\Z/
    end
  end
end