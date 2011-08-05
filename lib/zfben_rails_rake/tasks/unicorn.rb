namespace :unicorn do
  desc 'start server'
  task :start, [:env, :config] do |task, args|
    args = { :env => 'production', :config => 'unicorn.rb' }.merge args.to_hash
    cmd = 'unicorn_rails'
    cmd << ' -c ' << args[:config] if File.exists?(File.join(Rails.root, args[:config]))
    cmd << ' -E ' << args[:env]
    sys cmd << ' -D'
  end
  
  desc 'stop server'
  task :stop do
    sys 'kill -QUIT `cat tmp/unicorn.pid`' if File.exists? File.join(Rails.root, 'tmp', 'unicorn.pid')
    sleep 1
    sys 'rm -r tmp/*'
  end
  
  desc 'restart server'
  task :restart, [:env, :config] => [:stop, :start]
  
  desc 'copy unicorn.rb to root path'
  task :copy, [:processes] do |task, args|
    path = File.join(Rails.root, 'unicorn.rb')
    if File.exists? path
      err 'unicorn.rb is exists! Please remove it and run again.'
    else
      args = { :processes => 1 }.merge args.to_hash
      p file = "# Added by zfben_rails_rake\nworker_processes #{args[:processes]}\nlisten File.realpath(File.dirname(__FILE__)) << '/tmp/unicorn.sock', :tcp_nopush => true, :tcp_nodelay => true\npid 'tmp/unicorn.pid'\npreload_app true\n# End zfben_rails_rake"
      File.open(path, 'w'){ |f| f.write file }
    end
  end
end
