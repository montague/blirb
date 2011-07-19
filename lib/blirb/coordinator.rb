module Blirb
  class Coordinator  
    attr_reader :current_task, :tasks
    DEFAULT_TASKS = 'blirb_tasks/tasks.yml'

    def initialize file_path = nil
      load_tasks_from file_path
      # @tasks = tasks
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
      if remaining_tasks.empty?
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
    def load_tasks_from file_path
      @tasks = []
      puts Dir.pwd
      YAML.load_file(file_path || DEFAULT_TASKS)['tasks'].each do |raw_task|
        @tasks << Task.new(raw_task['description'],raw_task['test'])
      end
    end

    def remaining_tasks
      @tasks.select {|task| !task.passed?}
    end

    def integer? n
      n =~ /^\d+\Z/
    end
  end
end