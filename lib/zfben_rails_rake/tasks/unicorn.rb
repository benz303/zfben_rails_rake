if File.exists? Rails.root.join('unicorn.rb')
  namespace :unicorn do
    desc 'Start unicorn server'
    task :start => :stop do
      if File.exists? Rails.root.join('config.ru')
        cmd = 'unicorn'
      else
        cmd = 'unicorn_rails'
      end
      cmd << ' -c unicorn.rb -E production -D'
      zfben_rails_rake_system 'mkdir tmp' unless File.exists? Rails.root.join('tmp')
      zfben_rails_rake_system cmd
    end

    desc 'Stop unicorn server'
    task :stop do
      if File.exists? Rails.root.join('tmp/unicorn.pid')
        zfben_rails_rake_system 'kill -QUIT `cat tmp/unicorn.pid`'
        sleep 1
        zfben_rails_rake_system 'rm tmp/unicorn.pid' if File.exists? Rails.root.join('tmp/unicorn.pid')
      end
    end

    desc 'Hot restart unicorn server'
    task :restart do
      if File.exists? Rails.root.join('tmp/unicorn.pid')
        zfben_rails_rake_system 'kill -USR2 `cat tmp/unicorn.pid`'
      end
    end
  end
end
