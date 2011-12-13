if File.exists? Rails.root.join('.git')
  namespace :git do
    desc 'Git pull'
    task :pull do
      zfben_rails_rake_system 'git pull'
    end

    desc 'Git commit with your comment'
    task :commit, [:comment] do |task, args|
      args = args.to_hash
      zfben_rails_rake_system 'git add .'
      comment = args.has_key?(:comment) ? args[:comment] : `git status`
      zfben_rails_rake_system "git commit -m '#{comment}' -a"
    end

    desc 'Git push with your comment'
    task :push, [:comment] => [:commit] do |task, comment|
      zfben_rails_rake_system 'git push'
    end

    desc 'Clear files in .gitignore'
    task :clear do
      unless File.exists? Rails.root.join('.gitignore')
        zfben_rails_rake_err '.gitignore is not exists!'
      else
        zfben_rails_rake_system 'git clean -dfX'
      end
    end
  end
end
