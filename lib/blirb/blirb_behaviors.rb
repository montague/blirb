# adds blirb functionality

module BlirbBehaviors
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
        puts @blirb.current_task.description if @blirb.current_task
      end
    end
    
    def current_task_test!
      b = context.workspace.binding
      Object.class_eval do
        if @blirb.current_task.test!(b)
          puts "nice. that worked."
          puts "========================="
          @blirb.menu
        else
          puts "hahahaha... really? 10 push-ups and try again."
        end
      end
    end
    
    #for finger jockeys...
    alias :bm :blirb_methods
    alias :derp :blirb_methods
    alias :ctd :current_task_description
    alias :ctt! :current_task_test!
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end