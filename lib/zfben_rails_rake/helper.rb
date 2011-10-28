require 'rainbow'
require 'fileutils'
def sys cmd
  STDOUT.print (cmd + "\n").color(:green)
  err '' unless system cmd
end

def err msg
  STDOUT.print (msg + "\n").color(:red)
  exit!
end

if defined? Rails && !Rails.root.nil?
  ROOT = File.realpath(Rails.root)
else
  ROOT = File.dirname(__FILE__)
end
