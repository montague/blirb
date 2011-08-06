# adds blirb functionality
module Blirb
  module Behaviors
    module ClassMethods
    end

    module InstanceMethods

      def help!
        puts 
        Blirb::COMMANDS.each do |command|
          puts %{\t\t#{command}}
        end
        puts 
      end

      def task
        Object.class_eval do
          puts @blirb.current_task.description if @blirb.current_task
        end
      end

      def done
        b = context.workspace.binding
        Object.class_eval do
          if @blirb.current_task.test!(b)
            puts "Nice. That worked."
            puts "========================="
            @blirb.menu
          else
            puts "Test failed. Try again."
          end
        end
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
