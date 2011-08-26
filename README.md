# Blirb

### Currently only tested with Ruby ~> 1.9.2

Blirb is a ruby teaching and practice tool that sits on top of IRB, also known 
as the "Interactive Ruby Shell". It can be used in two different ways:

## Using Blirb to learn

As a student, Blirb can be used in tutorial mode by installing (`gem install blirb`) 
and then simply running `blirb`. Custom task files (as described below) can be passed as a 
single command line argument: `blirb custom_task_file.rb`.
The student selects a task to complete that involves various ruby concepts. 
He is then dropped into a special IRB session where several additional global 
commands have been added.


    The following commands are available during the tutorial (irb) session:
    
    	task - print the current task's description
    	done - test to see if you've completed the current task
    	help! - view this menu
    
    To exit from the tutorial menu, type 'q' or 'exit'.
    
    
Below the command list appears a list of selectable tasks:
    
    Please choose a task by entering a task number:

    0 - set a variable 'dude' with a value, any value
    1 - set an instance variable 'dude' with a value... any value
    
    > 


The student types the number of the task and hits enter to choose which task to 
complete. Once in the IRB shell, the student simply completes the task and uses 
the `done` command:

    Please choose a task by entering task number:
    
    0 - set a variable 'dude' with a value, any value
    1 - set an instance variable 'dude' with a value... any value
    
    > 0
    Ok. set a variable 'dude' with a value, any value. Let's get started.
    ruby-1.9.2-p180 :001 > dude = :hi_mom
     => :hi_mom 
    ruby-1.9.2-p180 :002 > done
    nice. that worked.
    =========================


After completing a task, the student arrives back at the initial task menu. 
Blirb remembers completed tasks and only lists those that haven't been 
completed in the current session. In the case below, only task 1 is shown 
because task 0 has already been completed.


    To exit from the tutorial menu, type 'q' or 'exit'.
    
    Please choose a task by entering task number:
    
    1 - set an instance variable 'dude' with a value... any value
    
    >


## Using Blirb to teach

Blirb has a tiny DSL used to define tasks in `blirb_tasks/tasks.rb`. A custom 
tasks file can also be passed in on the command line. Tasks can be defined as 
follows:

    task "description of task (this is what the student reads)", %{
      code that will be eval'd to test if the task has been passed
    }, %{
      code that, when eval'd, will cause the above test code to pass
    }


When Blirb is started up, it will read either the default task file located in 
`blirb_tasks/tasks.rb` or the one passed in on the command line.

## Final Thought

I'm not Jerry Springer, so you're out of luck. But, if you think this project 
is useful and would like to contribute, please fork it! I'd love for this to 
become a standard tool in a new rubyist's toolbox.
