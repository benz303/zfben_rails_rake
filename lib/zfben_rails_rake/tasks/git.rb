namespace :git do  
  desc 'Git pull'
  task :pull do
    sys 'git pull'
  end

  desc 'Git commit with your comment'
  task :commit, [:comment] do |task, args|
    args = args.to_hash
    sys "git add ."
    comment = args.has_key?(:comment) ? args[:comment] : `git status`
    sys "git commit -m '#{comment}' -a"
  end

  desc 'Git push with your comment'
  task :push, [:comment] => [:commit] do |task, comment|
    sys 'git push'
  end

  desc 'Clear files in .gitignore'
  task :clear do
    unless File.exists? ROOT + '/.gitignore'
      err '.gitignore is not exists! Please run `rake git:copy` first'
    else
      sys 'git clean -dfX'
    end
  end
end
