require 'rainbow'
def sys cmd
  STDOUT.print (cmd + "\n").color(:black).background(:white)
  system cmd
end

def err msg
  STDOUT.print (msg + "\n").color(:yellow).background(:red)
  exit!
end
