if File.exists? Rails.root.join('unicorn.rb')
  namespace :unicorn do
    desc 'Start unicorn server'
    task :start do
      if File.exists? Rails.root.join('config.ru')
        cmd = 'unicorn'
      else
        cmd = 'unicorn_rails'
      end
      zfben_rails_rake_system cmd << ' -c unicorn.rb -E production -D'
    end

    desc 'Stop unicorn server'
    task :stop do
      if File.exists? Rails.root.join('tmp/unicorn.pid')
        zfben_rails_rake_system 'kill -QUIT `cat tmp/unicorn.pid`'
        sleep 1
      end
      zfben_rails_rake_system 'rm -r tmp/*'
    end

    desc 'Restart unicorn server'
    task :restart => [:stop, :start]
  end
end
