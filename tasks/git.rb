namespace 'git' do  
  desc 'git pull'
  task :pull do
    sys 'git pull'
  end

  desc 'git commit with your comment'
  task :commit, [:comment] do |task, args|
    args = args.to_hash
    if args.has_key? :comment
      comment = `git status`
    else
      comment = args[:comment]
    end
    sys "git add .;git commit -m '#{comment}' -a"
  end
  
  desc 'git push with your comment'
  task :push, [:comment] => [:commit] do |task, comment|
    sys 'git push'
  end
end
