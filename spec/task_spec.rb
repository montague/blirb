require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "each task" do
  it "has verification code that allows it to pass" do
    TaskTester.new.tasks.each do |task|
      task.verify!(binding).should be_true
    end
  end
end
