require 'rainbow'
require 'fileutils'
require 'yaml'

def sys cmd
  STDOUT.print (cmd + "\n").color(:green)
  err '' unless system cmd
end

def err msg
  STDOUT.print (msg + "\n").color(:red)
  exit!
end

if defined?(Rails) && !Rails.root.nil?
  ROOT = File.realpath(Rails.root).to_s
else
  ROOT = File.realpath('.').to_s
end
