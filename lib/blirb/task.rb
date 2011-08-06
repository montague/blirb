# Represents a task that a user must complete
module Blirb
  class Task
    attr_reader :test,:description

    def initialize(description, test, verification_code)
      @description = description
      @passed = false
      @test = test
      @verification_code = verification_code
    end

    def test!(b)
      @passed = !!eval(@test,b)
    end

    def passed?
      @passed
    end
    
    def verify!(b)
      begin
        eval(@verification_code, b)
        test!(b)
      rescue
        false
      end
    end
  end
end
