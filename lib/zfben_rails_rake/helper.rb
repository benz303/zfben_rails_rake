require 'rainbow'
require 'fileutils'
def sys cmd
  STDOUT.print (cmd + "\n").color(:black).background(:white)
  err '' unless system cmd
end

def err msg
  STDOUT.print (msg + "\n").color(:yellow).background(:red)
  exit!
end

if defined? Rails
  ROOT = File.realpath(Rails.root)
else
  ROOT = File.dirname(__FILE__)
end
