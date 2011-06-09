namespace :git do  
  desc 'git pull'
  task :pull do
    sys 'git pull'
  end

  desc 'git commit with your comment'
  task :commit, [:comment] do |task, args|
    args = args.to_hash
    sys "git add ."
    comment = args.has_key?(:comment) ? args[:comment] : `git status`
    sys "git commit -m '#{comment}' -a"
  end
  
  desc 'git push with your comment'
  task :push, [:comment] => [:commit] do |task, comment|
    sys 'git push'
  end
  
  desc 'copy .gitignore to rails root path'
  task :copy do
    sys 'cp ' << File.join(ZfbenRailsRakePath, 'static', '.gitignore') << ' ' << Rails.root.to_s
  end
  
  desc 'clear files in .gitignore'
  task :clear do
    path = File.join(Rails.root, '.gitignore')
    unless File.exists? path
      err '.gitignore is not exists! Please run `rake git:copy` first'
    else
      sys 'git clean -dfX'
    end
  end
end
