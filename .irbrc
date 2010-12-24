# Stolen from http://www.viget.com/extend/practical-sorcery-with-irb/

require 'rubygems'
p 1
require 'pp'
p 2
require 'wirble'

Wirble.init
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true
p 3
class Object
  def my_methods
    (methods - Object.instance_methods).sort
  end
end

def ls
  %x{ls}.split("\n")
end
p 4
def cd(dir)
  Dir.chdir(dir)
  Dir.pwd
end

def pwd
  Dir.pwd
end
p 5
def rl(file_name = nil)
  if file_name.nil?
    if !@recent.nil?
      rl(@recent)
    else
      puts "No recent file to reload"
    end
  else
    file_name += '.rb' unless file_name =~ /\.rb/
    @recent = file_name
    load "#{file_name}"
  end
end

alias p pp
alias quit exit
puts "loaded"
