module Blirb
  class Coordinator  
    attr_reader :current_task, :tasks
    DEFAULT_TASKS = File.expand_path('../../../blirb_tasks/tasks.rb', __FILE__)
    
    def initialize file_path = nil
      @tasks = []
      load_tasks file_path  || DEFAULT_TASKS
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
      list_commands
      puts "\nPlease choose a task by entering task number (completed tasks will not appear):\n\n"
      list_tasks

      while true
        print "\n> "
        if integer?( (selection = gets.chomp) ) && @tasks[(selection = selection.to_i)]
          select_task selection
          break
        elsif selection == 'q' || selection == 'exit' # variety is the spice of life
          exit
        end
        puts "Sorry, I'm not sure what you're trying to do. Please do something different."
      end
    end

    private
    def list_commands
      puts "\nThe following commands are available during the tutorial (irb) session:\n\n"
      Blirb::COMMANDS.each do |command|
        puts "\t#{command}\n"
      end
      puts "\nTo exit from the tutorial menu, type 'q' or 'exit'.\n"
    end

    def select_task selection
      @current_task = @tasks[selection]
      puts "Ok. #{@current_task.description}. Let's get started."
    end

    def list_tasks
      @tasks.each_with_index do |task, index|
        puts "#{index} - #{task.description}" unless task.passed?
      end
    end

    def end_tutorial
      puts "Thanks for completing the tutorial. FORK ME ON GITHUB!"
      exit
    end

    def load_tasks file_path
      eval File.read(file_path)
    end

    # used for task definitions in blirb_tasks/tasks.rb
    def task description, test_code, validation_code
      @tasks << Task.new(description, test_code, validation_code)
    end

    def remaining_tasks
      @tasks.select {|task| !task.passed?}
    end

    def integer? n
      n =~ /^\d+\Z/
    end
  end
end