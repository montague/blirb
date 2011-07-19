# Represents a task that a user must complete
module Blirb
  class Task
    attr_reader :test,:description

    def initialize(description, test)
      @description = description
      @passed = false
      @test = test
    end

    def test!(b)
      @passed = !!eval(@test,b)
    end

    def passed?
      @passed
    end

  end
end