require 'rainbow'
require 'fileutils'
require 'yaml'

module ZfbenRailsRake::Helper
  def sys cmd
    cmd = 'bash ' << cmd
    STDOUT.print (cmd + "\n").color(:green)
    err unless system cmd
  end

  def err msg = 'Failed!'
    STDERR.print (msg + "\n").color(:red)
    exit!
  end

  if defined?(Rails) && !Rails.root.nil?
    ROOT = File.realpath(Rails.root).to_s
  else
    ROOT = File.realpath('.').to_s
  end
end
