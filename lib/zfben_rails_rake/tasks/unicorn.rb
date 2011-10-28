if File.exists? ROOT + '/unicorn.rb'
  namespace :unicorn do
    desc 'Start unicorn server'
    task :start do
      if File.exists? ROOT + '/config.ru'
        cmd = 'unicorn'
      else
        cmd = 'unicorn_rails'
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

    desc 'Hot restart server'
    task :restart do
      sys 'kill -HUP `cat tmp/unicorn.pid`'
    end
  end
end
