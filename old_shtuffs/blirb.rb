require 'irb'

#the idea is, ask for something. then, each time irb 
#evaluates something, run a test in the current context
#to see if the requested condition has been met.
#=> begin some heinous monkeypatching
module IRB
  
  class << IRB #open up eigenclass of IRB, monkey patch some shit
    alias :old_start :start
    #ok, we've entered IRB eigenland... but we still need the config code
    #executed in the right context, which ain't happening...
    def start
      Blirb.config_irb
      puts Blirb::WELCOME_MESSAGE
      old_start
    end
  end
  
  class WorkSpace
     def gimme_binding
       @binding
     end
   end

   class Context
     alias :old_set_last_value :set_last_value

     def set_last_value(value)
       old_set_last_value(value)
       Blirb.test(@workspace.gimme_binding)
     end

   end
  
end


module Blirb
  WELCOME_MESSAGE = "Hello, world. Welcome to blirb. Why don't you have a seat over there..."
  TESTS = []

  #=> end heinous monkey patching
  #fix display so that the task shows up and you are given feedback if you pass/fail
  #more monkeypatching magic, i guess
  def Blirb.load_tests
    TESTS.push(Test.new("create a class called 'F' that has an attribute of 'f'") do |b|
      eval('
      lambda {
        begin
          F.instance_methods.include?(:f)
        rescue
          false
        end
        }', b)
      end
      )

      TESTS.push(Test.new("declare a variable, 'x', with a value of 'say hey'") do |b|
        eval(' 
        lambda {
          begin 
            local_variables.include?(:x) && x == "say hey"
          rescue
            false
          end
          }', b)
        end
        )

      end

      def Blirb.start
        load_tests
        IRB.start
      end

      def Blirb.announce_me
        caller[0] =~ /`(.*?)`/
        print "#{$1}"
      end

      def Blirb.config_irb
        announce_me
        IRB.conf[:IRB_RC] = lambda do |conf|
          leader = " " * conf.irb_name.length
          conf.prompt_i = "#{conf.irb_name} --> "
          conf.prompt_s = leader + ' \-" '
          conf.prompt_c = leader + ' \-+ '
          conf.return_format = leader + " ==> %s\n\n"
          puts "Welcome, motherfucker!!"
        end
      end

      def Blirb.test(binding)
        unless TESTS.size.zero?
          t = TESTS.pop    
          puts t.instruction
          TESTS.push t unless t.test_code.call(binding).call      
        end
      end

      class Test
        attr_accessor :test_code
        attr_accessor :passed
        attr_accessor :instruction

        def initialize(ins,&p)
          @instruction = ins
          @test_code = p
          @passed = false
        end

      end
    end
if __FILE__ == $0
  Blirb.start
end