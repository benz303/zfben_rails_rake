p File.exists?(ROOT + '/config/initializers/resque.rb')
if File.exists?(ROOT + '/config/initializers/resque.rb')
  namespace :resque do
    desc 'Start Resque worker'
    task :start => ['resque:stop', :environment] do
      require ROOT + '/config/initializers/resque.rb'
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
  end
end
