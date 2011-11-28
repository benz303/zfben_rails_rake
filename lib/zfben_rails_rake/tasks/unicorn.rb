if File.exists? Rails.root.join('/unicorn.rb')
  namespace :unicorn do
    include ZfbenRailsRake::Helper
    desc 'Start unicorn server'
    task :start do
      if File.exists? ROOT + '/config.ru'
        cmd = 'rvm default do unicorn'
      else
        cmd = 'rvm default do unicorn_rails'
      end
      sys cmd << ' -c unicorn.rb -E production -D'
    end

    desc 'Stop unicorn server'
    task :stop do
      if File.exists? ROOT + '/tmp/unicorn.pid'
        sys 'kill -QUIT `cat tmp/unicorn.pid`'
        sleep 1
      end
      sys 'rm -r tmp/*'
    end

    desc 'Restart unicorn server'
    task :restart => [:stop, :start]
  end
end
