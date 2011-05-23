namespace 'git' do  
  desc 'git pull'
  task :pull do
    sys 'git pull'
  end

  desc 'git commit with your comment'
  task :commit, [:comment] do |task, args|
    args = args.to_hash
    comment = args.has_key?(:comment) ? args[:comment] : `git status`
    sys "git add ."
    sys "git commit -m '#{comment}' -a"
  end
  
  desc 'git push with your comment'
  task :push, [:comment] => [:commit] do |task, comment|
    sys 'git push'
  end
  
  desc 'copy .gitignore to rails root'
  task :copy do
    sys 'cp ' << File.join(Path, 'static', '.gitignore') << ' ' << Rails.root.to_s
  end
end
