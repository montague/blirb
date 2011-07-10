module BlirbObject
  module ClassMethods
    def blirb
      @blirb
    end
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
        puts @blirb.current_task.description if @blirb.current_task
      end
    end
    
    def current_task_test!
      b = context.workspace.binding
      Object.class_eval do
        if @blirb.current_task.test!(b)
          @blirb.current_task.pass!
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