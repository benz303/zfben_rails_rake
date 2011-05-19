namespace 'unicorn' do
  desc 'start server'
  task :start, :env, :config do |task, env, config|
    cmd = 'unicorn_rails'
    cmd << ' -c u.rb' if defined?(config.config) && File.exists?(File.join(Rails.root, config.config))
    cmd << ' -E ' << env.env if defined? env.env
    sys cmd << ' -D'
  end
  
  desc 'stop server'
  task :stop do
    sys 'kill -QUIT `cat tmp/unicorn.pid`' if File.exists? File.join(Rails.root, 'tmp/unicorn.pid')
  end
  
  desc 'restart server'
  task :restart, :env, :config, :needs => [:stop, :start]
end
