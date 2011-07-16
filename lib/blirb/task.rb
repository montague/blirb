# Represents a task that a user must complete
class Task
  attr_reader :test,:description

  def initialize(description, test)
    @description = description
    @passed = false
    @test = test
  end

  def test!(b)
    eval(@test,b)
  end

  def passed?
    @passed
  end

  def pass!
    @passed = true
  end
end
