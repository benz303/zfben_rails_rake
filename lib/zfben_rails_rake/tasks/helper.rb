def sys cmd
  STDOUT.puts cmd.color(:black).background(:white)
  system cmd
end

def err msg
  STDOUT.puts msg.color(:yellow).background(:red)
  exit!
end
