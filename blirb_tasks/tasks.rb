# Example tasks file
# 
# the format of a task is as follows:
# 
# task "description of task", %{
#   test code -- code to test that task was completed
# }, %{
#   verification code -- code that performs the task to that the test will pass 
# }

task "Set a variable 'dude' with a value, any value", %{
  defined?(dude)
}, %{
  dude = :dude
}

task "Set an instance variable 'dude' with a value... any value", %{
  defined?(@dude)
}, %{
  @dude = :dude
}

task "Create a class 'Bro' that has an instance method 'fist_bump'. The method should return a symbol ':yeah_bro'", %{
  Bro.new.fist_bump == :yeah_bro
}, %{
  class Bro
    def fist_bump
      :yeah_bro
    end
  end
}

task "Give 'Bro' a class method called 'protein_shake' that returns the string 'getting hyooge!'", %{
  Bro.protein_shake == 'getting hyooge'
}, %{
  class Bro
    def self.protein_shake
      "getting hyooge"
    end
  end
}

task "Define 'Bro' so that he has a private method 'drink_natty_ice'. The method should return :yah_dude", %{
  bro = Bro.new
  bro.private_methods.include?(:drink_natty_ice) && bro.send(:drink_natty_ice) == :yah_dude
}, %{
  class Bro
    private
    def drink_natty_ice
      :yah_dude
    end
  end
}

task "Create a 'Bro' object in the variable 'brah'. Give brah (and only brah) the ability to chug_chug_chug, which will return :full", %{
  broo = Bro.new
  (brah.chug_chug_chug == :full) && (brah.methods - broo.methods == [:chug_chug_chug]) && (brah.private_methods - broo.private_methods).empty?
}, %{
  brah = Bro.new
  def brah.chug_chug_chug
    :full
  end
}

task "Create a new 'LittleBro' object that inherits from 'Bro'", %{
  LittleBro.ancestors[1] == Bro
}, %{
  class Bro; end
  class LittleBro < Bro; end
}

