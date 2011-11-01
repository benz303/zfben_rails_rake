if File.exists?(ROOT + '/config/initializers/resque.rb')
  namespace :resque do
    desc 'Start Resque for debug'
    task :debug => :environment do
      require ROOT + '/config/initializers/resque.rb'
      worker = Resque::Worker.new('*')
      worker.work
    end

    desc 'Start Resque daemon worker'
    task :start => 'resque:stop' do
      RAILS_ENV = 'production'
      Rake::Task[:environment].execute
      work = fork do
        worker = Resque::Worker.new('*')
        Process.daemon true
        File.open(ROOT + '/tmp/resque.pid', 'w') { |f| f << Process.pid.to_s }
        worker.work
      end
      print "Resque worker running at #{work}\n"
    end

    desc 'Stop Resque worker'
    task :stop do
      path = ROOT + '/tmp/resque.pid'
      if File.exists?(path)
        sys "kill `cat #{path}`;rm #{path}"
      end
    end

    desc 'Clear Resque data'
    task :clear do
      require ROOT + '/config/initializers/resque.rb'
      Resque.redis.keys('*').each{ |k| Resque.redis.del k }
    end

    desc 'Start Resque web interface'
    task :web do
      require ROOT + '/config/initializers/resque.rb'
      require 'resque/server'
      Resque::Server.run!
    end
  end
end
