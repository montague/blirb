require 'irb'

class Blirb

  class ::Object
        
    def did_something?
      return true if instance_variable_defined? :"@x"
      false
    end
    
    def start_blirb
      Blirb.new.start binding
    end
  end
  def initialize tasks=nil
    @tasks = tasks
  end
  
  def start b
    puts "starting"...

    while true
      a = gets.chomp
      puts "you typed #{a}"
      if a == 'e'
        eval "def x; puts 'hello world.. i am born!!';end", b
        return 
      end
      # exit if tasks.any? { |t|  !t.passed? }
    end
  end


end

class Task
  def initialize description, &block
    @description = description
    @passed = false
    @test = block
  end
  
  def test!
   instance_eval &@test
  end
  
  def passed?
    @passed
  end
  
  def pass!
    @passed = true
  end
end
if __FILE__ == $0
  t = Task.new "hi mom" do 
    puts "from the block"
    puts "before: #{passed?}"
    pass!
    puts "after: #{passed?}"
  end
  
  t.test!
  # Blirb.new.start
end
