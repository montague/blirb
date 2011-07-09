module BlirbObject
  module ClassMethods
    
  end
  
  module InstanceMethods
    
    def blirb_methods
      puts %{
        current_task_description
        current_task_test!
      }
    end
    
    def current_task_description
      Object.class_eval do
        puts @current_task.description if @current_task
      end
    end
    
    def current_task_test!(b)
      Object.class_eval do
        if @current_task.test!(b)
          @current_task.pass!
          puts "nice. that worked."
        else
          puts "oops. you fucked up. 10 push-ups and try again."
        end
      end
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end