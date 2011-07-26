# Example tasks file
# 
# the format of a task is as follows:
# 
# task "description of task", %{
#   code to test that task was completed
# }

task "set a variable 'dude' with a value, any value", %{
  defined?(dude)
}

task "set an instance variable 'dude' with a value... any value", %{
  defined?(@dude)
}
