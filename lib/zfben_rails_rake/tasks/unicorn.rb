namespace 'unicorn' do
  desc 'start server'
  task :start, [:env, :config] do |task, args|
    args = { :env => 'development', :config => 'unicorn.rb' }.merge args.to_hash
    cmd = 'unicorn_rails'
    cmd << ' -c ' << args[:config] if args.has_key?(:config) && File.exists?(File.join(Rails.root, args[:config]))
    cmd << ' -E ' << args[:env] if args.has_key?(:env)
    sys cmd << ' -D'
  end
  
  desc 'stop server'
  task :stop do
    sys 'kill -QUIT `cat tmp/unicorn.pid`' if File.exists? File.join(Rails.root, 'tmp/unicorn.pid')
  end
  
  desc 'restart server'
  task :restart, [:env, :config] => [:stop, :start]
end
