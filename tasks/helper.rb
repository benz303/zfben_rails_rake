def sys cmd
  STDOUT.puts cmd.color(:black).background(:white)
  system cmd
end
