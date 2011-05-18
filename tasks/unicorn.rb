namespace 'unicorn' do
  desc 'start server'
  task :start, :env do |task, env|
    cmd = 'unicorn_rails'
    cmd << ' -c u.rb' if File.exists? File.join(Rails.root, 'u.rb')
    cmd << ' -E ' << env.env if env != {}
    sys cmd << ' -D'
  end
  
  desc 'stop server'
  task :stop do
    sys 'kill -QUIT `cat tmp/unicorn.pid`' if File.exists? File.join(Rails.root, 'tmp/unicorn.pid')
  end
  
  desc 'restart server'
  task :restart => [:stop, :start]
end
